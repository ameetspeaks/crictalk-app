import 'package:flutter/material.dart';
import '../../../config/routes.dart';
import '../../../shared/widgets/gradient_background.dart';

class StartMatchScreen extends StatelessWidget {
  const StartMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a Match'),
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
                'Create a new match',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fill in the match details to get started',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOption(
                        icon: Icons.sports_cricket,
                        title: 'Match Details',
                        subtitle: 'Set match name, type, overs, etc.',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.matchDetails);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.group,
                        title: 'Team Selection',
                        subtitle: 'Select teams for the match',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.teamSelection);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.people,
                        title: 'Team Squad',
                        subtitle: 'Select players for each team',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.teamSquad);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.swap_horiz,
                        title: 'Toss',
                        subtitle: 'Conduct the toss and choose batting/bowling',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.toss);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.person_add,
                        title: 'Add Scorer & Streamer',
                        subtitle: 'Invite scorers or set up live streaming',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.scorer);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.sports_cricket_outlined,
                        title: 'Select Players',
                        subtitle: 'Choose striker, non-striker, and bowler',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.playerSelection);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.score,
                        title: 'Start Scoring',
                        subtitle: 'Begin scoring the match',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.scoring);
                        },
                      ),
                      const Divider(),
                      _buildOption(
                        icon: Icons.live_tv,
                        title: 'Live Streaming',
                        subtitle: 'Set up live streaming for the match',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.liveStreaming);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

