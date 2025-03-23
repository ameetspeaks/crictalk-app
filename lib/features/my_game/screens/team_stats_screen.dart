import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class TeamStatsScreen extends StatelessWidget {
  const TeamStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Stats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('10', 'MATCHES'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard('3', 'WON'),
                  ),
                  Expanded(
                    child: _buildStatCard('5', 'LOST'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('1', 'TIE'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard('1', 'DRWAN'),
                  ),
                  Expanded(
                    child: _buildStatCard('30%', 'WIN'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('7', 'TOSS WIN'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard('7', 'BAT FIRST'),
                  ),
                  Expanded(
                    child: _buildStatCard('3', 'NR'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildStatCard('4', 'UPCOMING MATCHES', isFullWidth: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, {bool isFullWidth = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

