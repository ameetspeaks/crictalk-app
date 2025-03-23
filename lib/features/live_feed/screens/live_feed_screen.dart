import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';
import 'scoreboard_screen.dart';
import 'squad_screen.dart';
import 'match_info_screen.dart';

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({super.key});

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live: Trailblazers vs Cricrevo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_filled),
            onPressed: () {},
          ),
        ],
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'SCOREBOARD'),
                  Tab(text: 'COMMENTARY'),
                  Tab(text: 'SQUAD'),
                  Tab(text: 'INFO'),
                ],
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ScoreboardScreen(),
                  CommentaryScreen(),
                  SquadScreen(),
                  MatchInfoScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentaryScreen extends StatelessWidget {
  const CommentaryScreen({super.key});

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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1st Inn',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'TBZ 46/1 (5.0)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hardik 14(6)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Ravin 12(8)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'JK (3.0-0-26-1)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Economy: 8.67',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'JK back into to attack (2.0-0-10-1)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCommentaryItem(
            'TBZ 46/1 (5.0)',
            'Jk to Hardik, no run, short ball, drive back to bowler.',
            ballType: '0',
          ),
          _buildCommentaryItem(
            'TBZ 46/1 (4.5)',
            'Jk to Hardik, no run, short ball, drive back to bowler.',
            ballType: '0',
          ),
          _buildCommentaryItem(
            'TBZ 46/1 (4.4)',
            'Jk to Hardik, FOUR, short ball, beautiful cover drive',
            ballType: '4',
          ),
          _buildCommentaryItem(
            'TBZ 42/1 (4.3)',
            'Jk to Hardik, SIX, straight drive over bowler. Back to back boundary.',
            ballType: '6',
          ),
          _buildCommentaryItem(
            'TBZ 36/1 (4.2)',
            'Jk to Hardik, SIX, straight drive over bowler. Back to back boundary.',
            ballType: '6',
          ),
          _buildCommentaryItem(
            'TBZ 30/1 (4.1)',
            'Jk to Hardik, no run, short ball, drive back to bowler.',
            ballType: '0',
          ),
        ],
      ),
    );
  }

  Widget _buildCommentaryItem(String score, String commentary, {required String ballType}) {
    Color ballColor;
    switch (ballType) {
      case '4':
        ballColor = Colors.blue;
        break;
      case '6':
        ballColor = Colors.purple;
        break;
      default:
        ballColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: ballColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                ballType,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  commentary,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  score,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
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

