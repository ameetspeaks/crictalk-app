import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class TeamLeaderboardScreen extends StatefulWidget {
  const TeamLeaderboardScreen({super.key});

  @override
  State<TeamLeaderboardScreen> createState() => _TeamLeaderboardScreenState();
}

class _TeamLeaderboardScreenState extends State<TeamLeaderboardScreen> {
  bool _showBatting = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Leaderboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showBatting = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _showBatting ? const Color(0xFFFF9800) : Colors.white,
                        foregroundColor: _showBatting ? Colors.white : Colors.black,
                      ),
                      child: const Text('BAT'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showBatting = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_showBatting ? const Color(0xFFFF9800) : Colors.white,
                        foregroundColor: !_showBatting ? Colors.white : Colors.black,
                      ),
                      child: const Text('BOWL'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  bool isTopPlayer = index == 0;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF9800),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'T',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          if (isTopPlayer)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: const Text(
                        'Amit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _showBatting
                            ? 'Inn: 03 | Runs: 120 |AVG: 40.0 | SR: 136'
                            : 'Overs: 12 | Wkts: 8 | Econ: 7.2 | Avg: 18.5',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      trailing: isTopPlayer
                          ? null
                          : Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

