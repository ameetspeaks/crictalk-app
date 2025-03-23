import 'package:flutter/material.dart';

class MatchInfoScreen extends StatelessWidget {
  const MatchInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Info',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoItem('Match', '3rd'),
          _buildInfoItem('Tournament', 'Weekend CUP'),
          _buildInfoItem('Date', 'Tue 18th March 2025'),
          _buildInfoItem('Time', '09:00 AM'),
          _buildInfoItem('Toss', 'Trailblazer opt to Bat'),
          _buildInfoItem('Umpires', 'Kartik lyyer, Zen Shah'),
          _buildInfoItem('Ground', 'Noida Sports Ground'),
          _buildInfoItem('City', 'Noida'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

