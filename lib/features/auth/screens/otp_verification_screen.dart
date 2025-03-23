import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../config/routes.dart';
import '../../../services/auth_service.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/gradient_background.dart';

/// OTP Verification Screen
///
/// This screen allows users to enter the OTP sent to their phone number.
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  int _resendSeconds = 60;
  bool _isLoading = false;
  String _phoneNumber = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      setState(() {
        _phoneNumber = args;
      });
      
      // For testing, pre-fill with test OTP
      if (_phoneNumber == '+919670006261') {
        _controllers[0].text = '1';
        _controllers[1].text = '2';
        _controllers[2].text = '3';
        _controllers[3].text = '4';
        _controllers[4].text = '5';
        _controllers[5].text = '6';
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Start the resend timer
  ///
  /// Counts down from 60 seconds before allowing the user to resend the OTP.
  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
        _startResendTimer();
      }
    });
  }

  /// Handle OTP input changes
  ///
  /// Moves focus to the next field when a digit is entered.
  /// @param value The entered value
  /// @param index The index of the current field
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyOtp();
      }
    }
  }

  /// Verify the entered OTP
  ///
  /// Collects the OTP from all fields and sends it for verification.
  void _verifyOtp() async {
    final otp = _controllers.map((controller) => controller.text).join();
    
    if (otp.length != 6) {
      setState(() {
        _errorMessage = 'Please enter a valid 6-digit OTP';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      debugPrint('Verifying OTP: $otp');
      
      final authService = Provider.of<AuthService>(context, listen: false);
      final success = await authService.verifyOTP(otp);
      
      setState(() {
        _isLoading = false;
      });
      
      if (success) {
        debugPrint('OTP verification successful');
        
        // Check auth status to determine next screen
        if (authService.status == AuthStatus.profileIncomplete) {
          debugPrint('Navigating to profile setup');
          
          // Navigate to profile setup
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
            context, 
            AppRoutes.profileSetup, 
            (route) => false,
          );
        } else {
          debugPrint('Navigating to home');
          
          // Navigate to home
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
            context, 
            AppRoutes.home, 
            (route) => false,
          );
        }
      } else {
        debugPrint('OTP verification failed: ${authService.errorMessage}');
        
        setState(() {
          _errorMessage = authService.errorMessage ?? 'Invalid OTP';
        });
      }
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  /// Resend OTP
  ///
  /// Requests a new OTP to be sent to the user's phone number.
  void _resendOtp() async {
    if (_resendSeconds == 0) {
      setState(() {
        _resendSeconds = 60;
        _errorMessage = null;
      });
      _startResendTimer();
      
      // Clear OTP fields
      for (var controller in _controllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();

      try {
        debugPrint('Resending OTP to $_phoneNumber');
        
        final authService = Provider.of<AuthService>(context, listen: false);
        await authService.sendOTP(_phoneNumber);
        
        if (authService.errorMessage != null) {
          setState(() {
            _errorMessage = authService.errorMessage;
          });
          
          debugPrint('Error resending OTP: ${authService.errorMessage}');
        } else {
          debugPrint('OTP resent successfully');
          
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP resent successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
        
        debugPrint('Error resending OTP: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Verification Code',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'We have sent the verification code to\n$_phoneNumber',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                            (index) => SizedBox(
                              width: 45,
                              height: 55,
                              child: TextField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey[300]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) => _onOtpChanged(value, index),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (_errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Verify',
                            onPressed: _verifyOtp,
                            isLoading: _isLoading,
                            backgroundColor: Colors.green,
                            height: 55,
                            borderRadius: 12,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Didn't receive the code? ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: _resendOtp,
                              child: Text(
                                _resendSeconds > 0
                                    ? 'Resend in $_resendSeconds sec'
                                    : 'Resend OTP',
                                style: TextStyle(
                                  color: _resendSeconds > 0 ? Colors.grey : Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

