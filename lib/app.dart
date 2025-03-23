import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/otp_verification_screen.dart';
import 'features/auth/screens/profile_setup_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/splash/screens/splash_screen.dart';
import 'services/auth_service.dart';

/// Main application widget
///
/// This is the root widget of the application.
class SportsVaniApp extends StatelessWidget {
  const SportsVaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportsvani',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      routes: AppRoutes.routes,
    );
  }
}

/// Authentication wrapper widget
///
/// This widget handles the authentication state and redirects to the appropriate screen.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    // Show splash screen while initializing
    if (authService.status == AuthStatus.initial) {
      return const SplashScreen();
    }
    
    // Navigate based on auth status
    switch (authService.status) {
      case AuthStatus.authenticated:
        return const HomeScreen();
      case AuthStatus.profileIncomplete:
        return const ProfileSetupScreen();
      case AuthStatus.unauthenticated:
      default:
        return const SignupScreen();
    }
  }
}

