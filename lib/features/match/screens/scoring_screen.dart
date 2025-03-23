import 'package:flutter/material.dart';
import '../../../config/routes.dart';
import '../../../shared/widgets/gradient_background.dart';

class ScoringScreen extends StatefulWidget {
  const ScoringScreen({super.key});

  @override
  State<ScoringScreen> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  int _runs = 0;
  int _wickets = 0;
  double _overs = 0.0;
  String _currentBowler = 'Player 9';
  String _striker = 'Player 1';
  String _nonStriker = 'Player 2';
  int _strikerRuns = 0;
  int _nonStrikerRuns = 0;
  int _strikerBalls = 0;
  int _nonStrikerBalls = 0;
  int _bowlerRuns = 0;
  int _bowlerWickets = 0;
  int _bowlerBalls = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoring'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: Column(
          children: [
            _buildScorecard(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    _buildBatsmenInfo(),
                    const SizedBox(height: 16),
                    _buildBowlerInfo(),
                    const SizedBox(height: 16),
                    _buildRunButtons(),
                    const SizedBox(height: 16),
                    _buildExtraButtons(),
                    const SizedBox(height: 16),
                    _buildWicketButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScorecard() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Trailblazers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$_runs/$_wickets',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overs: $_overs',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Text(
                'CRR: 6.0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBatsmenInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Batsman',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'R',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'B',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'SR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    const Icon(Icons.sports_cricket, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      _striker,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '$_strikerRuns',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '$_strikerBalls',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _strikerBalls > 0
                      ? ((_strikerRuns / _strikerBalls) * 100).toStringAsFixed(1)
                      : '0.0',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  _nonStriker,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '$_nonStrikerRuns',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '$_nonStrikerBalls',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _nonStrikerBalls > 0
                      ? ((_nonStrikerRuns / _nonStrikerBalls) * 100).toStringAsFixed(1)
                      : '0.0',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBowlerInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Bowler',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'O',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'R',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'W',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'ER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  _currentBowler,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  (_bowlerBalls / 6).floor().toString() +
                      '.' +
                      (_bowlerBalls % 6).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '$_bowlerRuns',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '$_bowlerWickets',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _bowlerBalls > 0
                      ? (_bowlerRuns / (_bowlerBalls / 6)).toStringAsFixed(1)
                      : '0.0',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRunButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRunButton('0'),
        _buildRunButton('1'),
        _buildRunButton('2'),
        _buildRunButton('3'),
        _buildRunButton('4'),
        _buildRunButton('6'),
      ],
    );
  }

  Widget _buildRunButton(String runs) {
    final int runValue = int.parse(runs);
    Color buttonColor;
    
    switch (runValue) {
      case 0:
        buttonColor = Colors.grey;
        break;
      case 4:
        buttonColor = Colors.blue;
        break;
      case 6:
        buttonColor = Colors.purple;
        break;
      default:
        buttonColor = Colors.green;
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          _runs += runValue;
          _strikerRuns += runValue;
          _strikerBalls++;
          _bowlerRuns += runValue;
          _bowlerBalls++;
          _overs = (_bowlerBalls / 6).floor() + ((_bowlerBalls % 6) / 10);
          
          // Rotate strike for odd runs
          if (runValue % 2 == 1) {
            final temp = _striker;
            _striker = _nonStriker;
            _nonStriker = temp;
            
            final tempRuns = _strikerRuns;
            _strikerRuns = _nonStrikerRuns;
            _nonStrikerRuns = tempRuns;
            
            final tempBalls = _strikerBalls;
            _strikerBalls = _nonStrikerBalls;
            _nonStrikerBalls = tempBalls;
          }
          
          // End of over
          if (_bowlerBalls % 6 == 0) {
            final temp = _striker;
            _striker = _nonStriker;
            _nonStriker = temp;
            
            final tempRuns = _strikerRuns;
            _strikerRuns = _nonStrikerRuns;
            _nonStrikerRuns = tempRuns;
            
            final tempBalls = _strikerBalls;
            _strikerBalls = _nonStrikerBalls;
            _nonStrikerBalls = tempBalls;
            
            // Change bowler
            _showChangeBowlerDialog(context);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        runs,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildExtraButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildExtraButton('WD', Colors.orange),
        _buildExtraButton('NB', Colors.red),
        _buildExtraButton('B', Colors.teal),
        _buildExtraButton('LB', Colors.indigo),
      ],
    );
  }

  Widget _buildExtraButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _runs++;
          _bowlerRuns++;
          
          // No ball count
          if (label == 'NB') {
            // Show free hit indicator
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }

  Widget _buildWicketButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showWicketDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text(
          'WICKET',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showChangeBowlerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? selectedBowler;
        
        return AlertDialog(
          title: const Text('Change Bowler'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select the next bowler:'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select Bowler'),
                        value: selectedBowler,
                        items: List.generate(11, (index) => 'Player ${index + 1}')
                            .where((player) => player != _currentBowler)
                            .map((player) {
                          return DropdownMenuItem<String>(
                            value: player,
                            child: Text(player),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBowler = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedBowler != null) {
                  setState(() {
                    _currentBowler = selectedBowler!;
                    _bowlerRuns = 0;
                    _bowlerWickets = 0;
                    _bowlerBalls = 0;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showWicketDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String dismissalType = 'Bowled';
        String? newBatsman;
        
        return AlertDialog(
          title: const Text('Wicket!'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select dismissal type:'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dismissalType,
                        items: [
                          'Bowled',
                          'Caught',
                          'LBW',
                          'Run Out',
                          'Stumped',
                          'Hit Wicket',
                        ].map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dismissalType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Select new batsman:'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select Batsman'),
                        value: newBatsman,
                        items: List.generate(11, (index) => 'Player ${index + 1}')
                            .where((player) => player != _striker && player != _nonStriker)
                            .map((player) {
                          return DropdownMenuItem<String>(
                            value: player,
                            child: Text(player),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            newBatsman = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newBatsman != null) {
                  setState(() {
                    _wickets++;
                    _bowlerWickets++;
                    _bowlerBalls++;
                    _strikerBalls++;
                    _overs = (_bowlerBalls / 6).floor() + ((_bowlerBalls % 6) / 10);
                    
                    // Replace striker with new batsman
                    _striker = newBatsman!;
                    _strikerRuns = 0;
                    _strikerBalls = 0;
                    
                    // End of over
                    if (_bowlerBalls % 6 == 0) {
                      final temp = _striker;
                      _striker = _nonStriker;
                      _nonStriker = temp;
                      
                      final tempRuns = _strikerRuns;
                      _strikerRuns = _nonStrikerRuns;
                      _nonStrikerRuns = tempRuns;
                      
                      final tempBalls = _strikerBalls;
                      _strikerBalls = _nonStrikerBalls;
                      _nonStrikerBalls = tempBalls;
                      
                      // Change bowler
                      _showChangeBowlerDialog(context);
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Scoring Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Swap Batsmen'),
                onTap: () {
                  setState(() {
                    final temp = _striker;
                    _striker = _nonStriker;
                    _nonStriker = temp;
                    
                    final tempRuns = _strikerRuns;
                    _strikerRuns = _nonStrikerRuns;
                    _nonStrikerRuns = tempRuns;
                    
                    final tempBalls = _strikerBalls;
                    _strikerBalls = _nonStrikerBalls;
                    _nonStrikerBalls = tempBalls;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.change_circle),
                title: const Text('Change Bowler'),
                onTap: () {
                  Navigator.pop(context);
                  _showChangeBowlerDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.undo),
                title: const Text('Undo Last Action'),
                onTap: () {
                  // Implement undo functionality
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.live_tv),
                title: const Text('Start Live Streaming'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.liveStreaming);
                },
              ),
              ListTile(
                leading: const Icon(Icons.stop_circle),
                title: const Text('End Match'),
                onTap: () {
                  Navigator.pop(context);
                  _showEndMatchDialog(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEndMatchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('End Match?'),
          content: const Text('Are you sure you want to end the match?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('End Match'),
            ),
          ],
        );
      },
    );
  }
}

