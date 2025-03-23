import 'package:flutter/material.dart';
import 'dart:math';
import '../../../config/routes.dart';
import '../../../shared/widgets/gradient_background.dart';

class TossScreen extends StatefulWidget {
const TossScreen({super.key});

@override
State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> with SingleTickerProviderStateMixin {
late AnimationController _controller;
late Animation<double> _animation;

String _selectedTeam = 'Trailblazers';
String _selectedChoice = 'Heads';
String? _tossResult;
String? _tossWinner;
String? _decision;

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  
  _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  
  _controller.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        // Randomly determine toss result
        _tossResult = Random().nextBool() ? 'Heads' : 'Tails';
        _tossWinner = _tossResult == _selectedChoice ? _selectedTeam : 'CricRevo';
      });
    }
  });
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

void _flipCoin() {
  setState(() {
    _tossResult = null;
    _tossWinner = null;
    _decision = null;
  });
  _controller.reset();
  _controller.forward();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Toss'),
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
              'Match Toss',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Decide who bats or bowls first',
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
                    if (_tossResult == null) ...[
                      const Text(
                        'Toss Settings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Who will call the toss?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                            value: _selectedTeam,
                            items: const [
                              DropdownMenuItem(
                                value: 'Trailblazers',
                                child: Text('Trailblazers'),
                              ),
                              DropdownMenuItem(
                                value: 'CricRevo',
                                child: Text('CricRevo'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedTeam = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Call',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildChoiceChip('Heads', _selectedChoice == 'Heads', () {
                            setState(() {
                              _selectedChoice = 'Heads';
                            });
                          }),
                          const SizedBox(width: 16),
                          _buildChoiceChip('Tails', _selectedChoice == 'Tails', () {
                            setState(() {
                              _selectedChoice = 'Tails';
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _animation.value * 10 * pi,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.monetization_on,
                                    size: 60,
                                    color: Colors.amber[800],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _flipCoin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Flip Coin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Toss Result',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'It\'s $_tossResult!',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$_tossWinner won the toss',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Decision',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildChoiceChip('Bat', _decision == 'Bat', () {
                            setState(() {
                              _decision = 'Bat';
                            });
                          }),
                          const SizedBox(width: 16),
                          _buildChoiceChip('Bowl', _decision == 'Bowl', () {
                            setState(() {
                              _decision = 'Bowl';
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _decision != null
                              ? () {
                                  Navigator.pushNamed(context, AppRoutes.scorer);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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

Widget _buildChoiceChip(String label, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
}

