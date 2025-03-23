import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Live Stream Service
///
/// This service handles the creation and management of YouTube live streams.
/// It communicates with the backend API to create broadcasts and streams.
class LiveStreamService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _baseUrl = 'https://api.sportsvani.com/api';

  /// Create a new live stream
  ///
  /// Creates a new YouTube live stream with the provided details.
  /// @param title The title of the live stream
  /// @param description The description of the live stream
  /// @param privacy The privacy setting of the live stream (public, private, unlisted)
  /// @return A map containing the broadcast and stream IDs
  Future<Map<String, dynamic>> createLiveStream({
    required String title,
    required String description,
    required String privacy,
  }) async {
    try {
      debugPrint('Creating live stream: $title');
      
      // Get session token
      final String? sessionToken = await _secureStorage.read(key: 'session_token');
      
      if (sessionToken == null) {
        throw Exception('Session token not found');
      }
      
      // Prepare request body
      final Map<String, dynamic> body = {
        'action': 'createBroadcast',
        'title': title,
        'description': description,
        'privacy': privacy,
      };
      
      // Send request to backend
      final response = await http.post(
        Uri.parse('$_baseUrl/youtube/create_broadcast.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionToken',
        },
        body: jsonEncode(body),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data['success']) {
          debugPrint('Live stream created successfully: ${data['broadcastId']}');
          return {
            'success': true,
            'broadcastId': data['broadcastId'],
            'streamId': data['streamId'],
            'streamUrl': data['streamUrl'],
            'streamKey': data['streamKey'],
          };
        } else {
          throw Exception(data['error'] ?? 'Failed to create live stream');
        }
      } else {
        throw Exception('Failed to create live stream: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error creating live stream: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Get authorization URL
  ///
  /// Gets the URL for authorizing the app to access the user's YouTube account.
  /// @return The authorization URL
  Future<String> getAuthorizationUrl() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/youtube/get_auth_url.php'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data.containsKey('authUrl')) {
          return data['authUrl'];
        } else {
          throw Exception('Authorization URL not found in response');
        }
      } else {
        throw Exception('Failed to get authorization URL: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error getting authorization URL: $e');
      rethrow;
    }
  }

  /// Check authorization status
  ///
  /// Checks if the user has authorized the app to access their YouTube account.
  /// @return A boolean indicating whether the user is authorized
  Future<bool> checkAuthorizationStatus() async {
    try {
      // Get session token
      final String? sessionToken = await _secureStorage.read(key: 'session_token');
      
      if (sessionToken == null) {
        return false;
      }
      
      final response = await http.get(
        Uri.parse('$_baseUrl/youtube/check_auth_status.php'),
        headers: {
          'Authorization': 'Bearer $sessionToken',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['authorized'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error checking authorization status: $e');
      return false;
    }
  }

  /// For testing purposes - simulate creating a live stream
  ///
  /// This method simulates the creation of a live stream without making actual API calls.
  /// @param title The title of the live stream
  /// @param description The description of the live stream
  /// @param privacy The privacy setting of the live stream
  /// @return A map containing mock broadcast and stream IDs
  Future<Map<String, dynamic>> simulateCreateLiveStream({
    required String title,
    required String description,
    required String privacy,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    
    return {
      'success': true,
      'broadcastId': 'mock-broadcast-id-${DateTime.now().millisecondsSinceEpoch}',
      'streamId': 'mock-stream-id-${DateTime.now().millisecondsSinceEpoch}',
      'streamUrl': 'rtmp://a.rtmp.youtube.com/live2',
      'streamKey': 'mock-stream-key-${DateTime.now().millisecondsSinceEpoch}',
    };
  }
}

