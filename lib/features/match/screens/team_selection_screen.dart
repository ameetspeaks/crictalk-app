import 'package:flutter/material.dart';
import '../../../config/routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/gradient_background.dart';

class TeamSelectionScreen extends StatefulWidget {
const TeamSelectionScreen({super.key});

@override
State<TeamSelectionScreen> createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends State<TeamSelectionScreen> {
String? _teamA;
String? _teamB;

final List<String> _availableTeams = [
  'Trailblazers',
  'Cricrevo',
  'Super Kings',
  'Royal Challengers',
  'Mumbai Indians',
  'Delhi Capitals',
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Team Selection'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: GradientBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Teams',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose teams for the match',
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
                      _buildTeamSelector(
                        label: 'Team A',
                        value: _teamA,
                        teams: _availableTeams,
                        onChanged: (value) {
                          setState(() {
                            _teamA = value;
                            // If both teams are the same, reset team B
                            if (_teamA == _teamB) {
                              _teamB = null;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildTeamSelector(
                        label: 'Team B (Opponent)',
                        value: _teamB,
                        teams: _availableTeams.where((team) => team != _teamA).toList(),
                        onChanged: (value) {
                          setState(() {
                            _teamB = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Create New Team',
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.createTeam);
                              },
                              isOutlined: true,
                              backgroundColor: Colors.blue,
                              height: 56,
                              borderRadius: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomButton(
                              text: 'Continue',
                              onPressed: (_teamA != null && _teamB != null)
                                  ? () {
                                      Navigator.pushNamed(context, AppRoutes.teamSquad);
                                    }
                                  : null,
                              backgroundColor: Colors.blue,
                              height: 56,
                              borderRadius: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildTeamSelector({
  required String label,
  required String? value,
  required List<String> teams,
  required void Function(String?) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: const Text('Select a team'),
            isExpanded: true,
            items: teams.map((String team) {
              return DropdownMenuItem<String>(
                value: team,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: team == 'Trailblazers'
                            ? Colors.orange
                            : team == 'Cricrevo'
                                ? Colors.blue
                                : Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          team[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      team,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
      if (value != null)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: value == 'Trailblazers'
                      ? Colors.orange
                      : value == 'Cricrevo'
                          ? Colors.blue
                          : Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    value[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Captain: John Doe',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.teamDetails);
                },
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
    ],
  );
}
}

