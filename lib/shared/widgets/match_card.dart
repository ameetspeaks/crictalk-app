import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
final String team1;
final String team2;
final String matchType;
final String venue;
final String location;
final VoidCallback onTap;
final bool isLive;
final String? score1;
final String? score2;
final String? overs1;
final String? overs2;
final String? result;

const MatchCard({
  super.key,
  required this.team1,
  required this.team2,
  this.matchType = 'League Match',
  this.venue = 'Noida Stadium',
  this.location = 'Noida',
  required this.onTap,
  this.isLive = false,
  this.score1,
  this.score2,
  this.overs1,
  this.overs2,
  this.result,
});

@override
Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
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
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                const Icon(Icons.play_circle_fill, color: Colors.red),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _buildTeamLogo(team1[0]),
                    const SizedBox(height: 8),
                    Text(
                      team1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (score1 != null)
                      Text(
                        score1!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    if (overs1 != null)
                      Text(
                        '($overs1 overs)',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                const Text(
                  'VS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Column(
                  children: [
                    _buildTeamLogo(team2[0]),
                    const SizedBox(height: 8),
                    Text(
                      team2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (score2 != null)
                      Text(
                        score2!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    if (overs2 != null)
                      Text(
                        '($overs2 overs)',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '$matchType | $venue, $location',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            if (result != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  result!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildTeamLogo(String letter) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        letter,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
  );
}
}

