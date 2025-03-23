import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/live_stream_service.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../../../shared/widgets/custom_button.dart';

/// Live Streaming Screen
///
/// This screen allows users to set up and start a YouTube live stream.
class LiveStreamingScreen extends StatefulWidget {
  const LiveStreamingScreen({super.key});

  @override
  State<LiveStreamingScreen> createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _privacy = 'public';
  bool _isStreaming = false;
  bool _isLoading = false;
  String? _errorMessage;
  
  // Stream details
  String? _streamUrl;
  String? _streamKey;
  String? _broadcastId;

  @override
  void initState() {
    super.initState();
    _titleController.text = 'Trailblazers vs CricRevo';
    _descriptionController.text = 'Live cricket match between Trailblazers and CricRevo';
    _checkAuthorizationStatus();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Check if the user has authorized the app to access their YouTube account
  Future<void> _checkAuthorizationStatus() async {
    try {
      final liveStreamService = Provider.of<LiveStreamService>(context, listen: false);
      final isAuthorized = await liveStreamService.checkAuthorizationStatus();
      
      if (!isAuthorized) {
        // Show authorization dialog
        if (!mounted) return;
        _showAuthorizationDialog();
      }
    } catch (e) {
      debugPrint('Error checking authorization status: $e');
    }
  }

  /// Show a dialog to authorize the app to access the user's YouTube account
  void _showAuthorizationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('YouTube Authorization Required'),
        content: const Text(
          'To create a live stream, you need to authorize this app to access your YouTube account.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _authorizeYouTube();
            },
            child: const Text('Authorize'),
          ),
        ],
      ),
    );
  }

  /// Authorize the app to access the user's YouTube account
  Future<void> _authorizeYouTube() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      
      final liveStreamService = Provider.of<LiveStreamService>(context, listen: false);
      final authUrl = await liveStreamService.getAuthorizationUrl();
      
      setState(() {
        _isLoading = false;
      });
      
      // For testing purposes, we'll just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('YouTube authorization successful'),
          backgroundColor: Colors.green,
        ),
      );
      
      // In a real app, you would open the authUrl in a WebView or browser
      // and handle the redirect back to your app
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      
      debugPrint('Error authorizing YouTube: $e');
    }
  }

  /// Create a new YouTube live stream
  Future<void> _createLiveStream() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      
      final liveStreamService = Provider.of<LiveStreamService>(context, listen: false);
      final result = await liveStreamService.simulateCreateLiveStream(
        title: _titleController.text,
        description: _descriptionController.text,
        privacy: _privacy,
      );
      
      if (result['success']) {
        setState(() {
          _isLoading = false;
          _isStreaming = true;
          _streamUrl = result['streamUrl'];
          _streamKey = result['streamKey'];
          _broadcastId = result['broadcastId'];
        });
        
        debugPrint('Live stream created: ${result['broadcastId']}');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = result['error'];
        });
        
        debugPrint('Error creating live stream: ${result['error']}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      
      debugPrint('Error creating live stream: $e');
    }
  }

  /// End the current live stream
  void _endLiveStream() {
    setState(() {
      _isStreaming = false;
    });
    
    // In a real app, you would call an API to end the live stream
    debugPrint('Live stream ended');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Streaming'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stream Setup',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Configure your live stream settings',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
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
                  child: _isStreaming
                      ? _buildStreamingView()
                      : _buildStreamSetupForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the stream setup form
  Widget _buildStreamSetupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stream Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _titleController,
          label: 'Title',
          hintText: 'Enter stream title',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _descriptionController,
          label: 'Description',
          hintText: 'Enter stream description',
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        const Text(
          'Privacy',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildPrivacyChip('public', _privacy == 'public', () {
              setState(() {
                _privacy = 'public';
              });
            }),
            const SizedBox(width: 16),
            _buildPrivacyChip('private', _privacy == 'private', () {
              setState(() {
                _privacy = 'private';
              });
            }),
            const SizedBox(width: 16),
            _buildPrivacyChip('unlisted', _privacy == 'unlisted', () {
              setState(() {
                _privacy = 'unlisted';
              });
            }),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Stream Preview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.videocam,
                size: 48,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        if (_errorMessage != null)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 16),
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
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: CustomButton(
            text: 'Start Streaming',
            onPressed: _createLiveStream,
            isLoading: _isLoading,
            backgroundColor: Colors.red,
            height: 55,
            borderRadius: 12,
          ),
        ),
      ],
    );
  }

  /// Build the streaming view
  Widget _buildStreamingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fiber_manual_record,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(width: 4),
              Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _titleController.text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _privacy,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stream Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('Stream URL:', _streamUrl ?? 'rtmp://a.rtmp.youtube.com/live2'),
              _buildInfoRow('Stream Key:', _streamKey ?? 'xxxx-xxxx-xxxx-xxxx'),
              _buildInfoRow('Broadcast ID:', _broadcastId ?? 'xxxx-xxxx-xxxx-xxxx'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.videocam,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStreamControlButton(
              icon: Icons.mic,
              label: 'Mute',
              onPressed: () {},
            ),
            _buildStreamControlButton(
              icon: Icons.flip_camera_ios,
              label: 'Flip',
              onPressed: () {},
            ),
            _buildStreamControlButton(
              icon: Icons.chat,
              label: 'Chat',
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: CustomButton(
            text: 'End Stream',
            onPressed: _endLiveStream,
            backgroundColor: Colors.red,
            height: 55,
            borderRadius: 12,
          ),
        ),
      ],
    );
  }

  /// Build a text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
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
        ),
      ],
    );
  }

  /// Build a privacy chip
  Widget _buildPrivacyChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Build a stream control button
  Widget _buildStreamControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: Colors.blue,
          iconSize: 32,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Build an info row
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

