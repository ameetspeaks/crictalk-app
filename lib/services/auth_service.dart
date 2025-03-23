import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'api_service.dart';

/// Authentication status enum
///
/// Represents the different states of user authentication in the app.
enum AuthStatus {
  /// Initial state when the app is starting
  initial,
  
  /// User is authenticated and has a complete profile
  authenticated,
  
  /// User is not authenticated
  unauthenticated,
  
  /// User is authenticated but profile is incomplete
  profileIncomplete,
}

/// Authentication service
///
/// This service handles user authentication using Firebase Phone Authentication.
/// It manages the authentication state, OTP verification, and user profile.
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final ApiService _apiService = ApiService();

  AuthStatus _status = AuthStatus.initial;
  User? _firebaseUser;
  UserModel? _user;
  String? _verificationId;
  int? _resendToken;
  String? _errorMessage;
  bool _isLoading = false;

  // Getters
  AuthStatus get status => _status;
  User? get firebaseUser => _firebaseUser;
  UserModel? get user => _user;
  String? get verificationId => _verificationId;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  /// Constructor
  ///
  /// Initializes the authentication service and checks the current auth state.
  AuthService() {
    _initializeAuth();
  }

  /// Initialize authentication
  ///
  /// Checks the current authentication state and updates the status accordingly.
  Future<void> _initializeAuth() async {
    debugPrint('Initializing AuthService');
    
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) async {
      debugPrint('Auth state changed: ${user != null ? 'User logged in' : 'No user'}');
      _firebaseUser = user;
      
      if (user == null) {
        _status = AuthStatus.unauthenticated;
      } else {
        // Check if profile is complete
        await _checkProfileStatus();
      }
      
      notifyListeners();
    });

    // Check if we have a stored session token
    try {
      final String? sessionToken = await _secureStorage.read(key: 'session_token');
      
      if (sessionToken != null) {
        debugPrint('Found session token, verifying with API');
        
        try {
          // Verify session token with API
          final response = await _apiService.verifySession(sessionToken);
          
          if (response['success']) {
            _user = UserModel.fromJson(response['user']);
            _status = AuthStatus.authenticated;
            debugPrint('Session token verified, user authenticated');
          } else {
            // Session expired or invalid
            await _secureStorage.delete(key: 'session_token');
            _status = AuthStatus.unauthenticated;
            debugPrint('Session token invalid, user unauthenticated');
          }
        } catch (e) {
          debugPrint('Error verifying session token: $e');
          _status = AuthStatus.unauthenticated;
        }
      } else {
        // No session token, check Firebase auth
        final currentUser = _auth.currentUser;
        
        if (currentUser != null) {
          debugPrint('Found Firebase user: ${currentUser.uid}');
          _firebaseUser = currentUser;
          await _checkProfileStatus();
        } else {
          debugPrint('No Firebase user found');
          _status = AuthStatus.unauthenticated;
        }
      }
    } catch (e) {
      debugPrint('Error in _initializeAuth: $e');
      _status = AuthStatus.unauthenticated;
    }
    
    notifyListeners();
  }

  /// Check if user profile is complete
  ///
  /// Reads the profile_complete flag from secure storage and updates the status.
  Future<void> _checkProfileStatus() async {
    try {
      final String? profileComplete = await _secureStorage.read(key: 'profile_complete');
      
      if (profileComplete == 'true') {
        debugPrint('Profile is complete');
        _status = AuthStatus.authenticated;
      } else {
        debugPrint('Profile is incomplete');
        _status = AuthStatus.profileIncomplete;
      }
    } catch (e) {
      debugPrint('Error checking profile status: $e');
      _status = AuthStatus.profileIncomplete;
    }
  }

  /// Send OTP to the provided phone number
  ///
  /// Initiates the phone verification process with Firebase.
  /// @param phoneNumber The phone number to send the OTP to
  Future<void> sendOTP(String phoneNumber) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      debugPrint('Sending OTP to $phoneNumber');
      
      // For testing purposes - bypass Firebase for specific test numbers
      if (phoneNumber == '+919670006261') {
        debugPrint('Using test phone number, bypassing Firebase');
        _verificationId = 'test-verification-id';
        _isLoading = false;
        notifyListeners();
        return;
      }
      
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint('Auto-verification completed');
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Verification failed: ${e.message}');
          _isLoading = false;
          _errorMessage = e.message;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint('Code sent to phone number');
          _verificationId = verificationId;
          _resendToken = resendToken;
          _isLoading = false;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Code auto retrieval timeout');
          _verificationId = verificationId;
          _isLoading = false;
          notifyListeners();
        },
        forceResendingToken: _resendToken,
      );
    } catch (e) {
      debugPrint('Error sending OTP: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Verify OTP code
  ///
  /// Verifies the OTP code entered by the user.
  /// @param otp The OTP code to verify
  /// @return A boolean indicating whether the verification was successful
  Future<bool> verifyOTP(String otp) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      debugPrint('Verifying OTP: $otp');
      
      // For testing purposes - bypass Firebase for test verification ID
      if (_verificationId == 'test-verification-id' && otp == '123456') {
        debugPrint('Using test verification, bypassing Firebase');
        
        // Simulate successful verification
        await _secureStorage.write(key: 'profile_complete', value: 'false');
        _status = AuthStatus.profileIncomplete;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      if (_verificationId == null) {
        throw Exception('Verification ID is null. Please request OTP again.');
      }
      
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      
      return await _signInWithCredential(credential);
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Sign in with phone auth credential
  ///
  /// Signs in the user with the provided credential.
  /// @param credential The phone auth credential
  /// @return A boolean indicating whether the sign-in was successful
  Future<bool> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      debugPrint('Signing in with credential');
      
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      _firebaseUser = userCredential.user;
      
      if (_firebaseUser != null) {
        debugPrint('User signed in: ${_firebaseUser!.uid}');
        
        // Get Firebase ID token
        final String? idToken = await _firebaseUser!.getIdToken();
        
        if (idToken != null) {
          debugPrint('Got ID token, verifying with backend');
          
          // Verify with backend
          final response = await _apiService.verifyPhone(idToken);
          
          if (response['success']) {
            // Save session token
            final String sessionToken = response['session_token'];
            await _secureStorage.write(key: 'session_token', value: sessionToken);
            
            // Check if user exists
            if (response['user_exists']) {
              _user = UserModel.fromJson(response['user']);
              await _secureStorage.write(key: 'profile_complete', value: 'true');
              _status = AuthStatus.authenticated;
            } else {
              _status = AuthStatus.profileIncomplete;
            }
            
            _isLoading = false;
            notifyListeners();
            return true;
          } else {
            throw Exception(response['message'] ?? 'Failed to verify with backend');
          }
        } else {
          throw Exception('Failed to get ID token');
        }
      } else {
        throw Exception('User is null after sign in');
      }
    } catch (e) {
      debugPrint('Error signing in: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Set user profile as complete
  ///
  /// Updates the user profile and marks it as complete.
  /// @param userModel The user model with profile information
  /// @return A boolean indicating whether the profile was successfully updated
  Future<bool> setProfileComplete(UserModel userModel) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      debugPrint('Setting profile as complete');
      
      // Get session token
      final String? sessionToken = await _secureStorage.read(key: 'session_token');
      
      if (sessionToken == null) {
        throw Exception('Session token not found');
      }
      
      // Send profile data to API
      final response = await _apiService.completeProfile(userModel, sessionToken);
      
      if (response['success']) {
        _user = UserModel.fromJson(response['user']);
        await _secureStorage.write(key: 'profile_complete', value: 'true');
        _status = AuthStatus.authenticated;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception(response['message'] ?? 'Failed to complete profile');
      }
    } catch (e) {
      debugPrint('Error completing profile: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Sign out the current user
  ///
  /// Signs out the user from Firebase and clears the session.
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      debugPrint('Signing out');
      await _auth.signOut();
      await _secureStorage.delete(key: 'profile_complete');
      await _secureStorage.delete(key: 'session_token');
      _status = AuthStatus.unauthenticated;
      _user = null;
      debugPrint('Signed out successfully');
    } catch (e) {
      debugPrint('Error signing out: $e');
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get current user's Firebase ID token
  ///
  /// @return The Firebase ID token or null if not available
  Future<String?> getIdToken() async {
    try {
      return await _firebaseUser?.getIdToken();
    } catch (e) {
      debugPrint('Error getting ID token: $e');
      return null;
    }
  }
}

