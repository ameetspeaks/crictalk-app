import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'config/firebase_config.dart';
import 'services/auth_service.dart';
import 'services/live_stream_service.dart';

/// Entry point of the application
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with platform-specific options
    await Firebase.initializeApp(
      options: _getFirebaseOptions(),
    );
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Failed to initialize Firebase: $e');
  }
  
  // Run the app with providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<LiveStreamService>(
          create: (_) => LiveStreamService(),
        ),
      ],
      child: const SportsVaniApp(),
    ),
  );
}

/// Get the appropriate Firebase options based on the platform
FirebaseOptions _getFirebaseOptions() {
  if (Platform.isIOS) {
    return FirebaseConfig.iosOptions;
  } else if (Platform.isAndroid) {
    return FirebaseConfig.androidOptions;
  } else {
    return FirebaseConfig.webOptions;
  }
}

