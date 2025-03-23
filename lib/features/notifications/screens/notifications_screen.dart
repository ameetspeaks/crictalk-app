import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all as read',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: GradientBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 10,
          itemBuilder: (context, index) {
            final bool isUnread = index < 3;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isUnread ? Colors.white : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
                border: isUnread
                    ? Border.all(color: Colors.blue, width: 1)
                    : null,
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isUnread ? Colors.blue.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getNotificationIcon(index),
                    color: isUnread ? Colors.blue : Colors.grey,
                  ),
                ),
                title: Text(
                  _getNotificationTitle(index),
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getNotificationDescription(index),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${index + 1} hour${index == 0 ? '' : 's'} ago',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getNotificationIcon(int index) {
    final icons = [
      Icons.sports_cricket,
      Icons.people,
      Icons.event,
      Icons.chat,
      Icons.star,
    ];
    return icons[index % icons.length];
  }

  String _getNotificationTitle(int index) {
    final titles = [
      'Match Reminder',
      'Team Update',
      'Tournament Invitation',
      'New Message',
      'Performance Update',
    ];
    return titles[index % titles.length];
  }

  String _getNotificationDescription(int index) {
    final descriptions = [
      'Your match with Cricrevo starts in 2 hours',
      'Amit has joined your team Trailblazers',
      'You have been invited to participate in Saturday Cricket League',
      'You have a new message from Abhinav',
      'Congratulations! You scored the highest runs in your last match',
    ];
    return descriptions[index % descriptions.length];
  }
}

