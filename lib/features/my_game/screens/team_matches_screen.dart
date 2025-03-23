import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class TeamMatchesScreen extends StatelessWidget {
  const TeamMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Matches'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildMatchCard(
              leagueName: 'Saturday Cricket League Season 1',
              team1: 'Trailblazers',
              team2: 'Cricrevo',
              matchInfo: 'Match scheduled to begin at Sun, 16 Mar, 10:00 AM',
              isUpcoming: true,
            ),
            const SizedBox(height: 16),
            _buildMatchCard(
              leagueName: 'Saturday Cricket League Season 1',
              team1: 'Trailblazers',
              team1Score: '201/3 (20.0)',
              team2: 'Cricrevo',
              team2Score: '204/3 (19.1)',
              matchInfo: 'Cricrevo won by 7 wickets',
              isUpcoming: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard({
    required String leagueName,
    required String team1,
    String? team1Score,
    required String team2,
    String? team2Score,
    required String matchInfo,
    required bool isUpcoming,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leagueName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUpcoming ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isUpcoming ? 'UPCOMING' : 'Result',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      team1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (team1Score != null)
                      Text(
                        team1Score,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      team2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (team2Score != null)
                      Text(
                        team2Score,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  matchInfo,
                  style: TextStyle(
                    color: isUpcoming ? Colors.blue[700] : Colors.green[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

