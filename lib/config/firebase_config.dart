import 'package:firebase_core/firebase_core.dart';

/// Firebase configuration for the Sportsvani app
///
/// This class provides the Firebase options for initializing the Firebase app.
/// It contains the API key, project ID, and other configuration parameters.
class FirebaseConfig {
  /// Firebase API key
  static const String apiKey = "AIzaSyCiPdQyHOXXVt-2VDMtDpzD5nH2D7dZNCA";
  
  /// Firebase auth domain
  static const String authDomain = "sportsvaniapp-01.firebaseapp.com";
  
  /// Firebase project ID
  static const String projectId = "sportsvaniapp-01";
  
  /// Firebase storage bucket
  static const String storageBucket = "sportsvaniapp-01.firebasestorage.app";
  
  /// Firebase messaging sender ID
  static const String messagingSenderId = "721212630242";
  
  /// Firebase app ID
  static const String appId = "1:721212630242:web:08cbc328a87e4975fa6abb";
  
  /// Firebase measurement ID
  static const String measurementId = "G-WPC81X4HCK";

  /// Firebase options for web platform
  static FirebaseOptions get webOptions => FirebaseOptions(
    apiKey: apiKey,
    authDomain: authDomain,
    projectId: projectId,
    storageBucket: storageBucket,
    messagingSenderId: messagingSenderId,
    appId: appId,
    measurementId: measurementId,
  );

  /// Firebase options for Android platform
  static FirebaseOptions get androidOptions => FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
  );

  /// Firebase options for iOS platform
  static FirebaseOptions get iosOptions => FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
    iosBundleId: 'com.sportsvani.app',
  );
}

