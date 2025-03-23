import 'package:flutter/material.dart';
import '../../../config/routes.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../../../shared/widgets/match_card.dart';
import '../../live_feed/screens/live_feed_screen.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
late TabController _tabController;
int _currentIndex = 0;

@override
void initState() {
  super.initState();
  _tabController = TabController(length: 3, vsync: this);
}

@override
void dispose() {
  _tabController.dispose();
  super.dispose();
}

void _onItemTapped(int index) {
  setState(() {
    _currentIndex = index;
  });
  
  // Navigate to the appropriate screen based on the bottom nav index
  if (index == 1) {
    Navigator.pushNamed(context, AppRoutes.teams);
  } else if (index == 3) {
    Navigator.pushNamed(context, AppRoutes.highlights);
  } else if (index == 4) {
    Navigator.pushNamed(context, AppRoutes.settings);
  }
}

@override
Widget build(BuildContext context) {
  return WillPopScope(
    // Prevent back navigation from home screen
    onWillPop: () async => false,
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        title: const Text('Sportsvani'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.chat);
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Live Stream Your Match?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.startMatch);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('START MATCH'),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'LIVE'),
                Tab(text: 'UPCOMING'),
                Tab(text: 'HIGHLIGHTS'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMatchList(isLive: true),
                  _buildMatchList(isLive: false),
                  _buildHighlightsList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_cricket),
            label: 'My Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Highlights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    ),
  );
}

Widget _buildMatchList({required bool isLive}) {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return MatchCard(
        team1: 'Trailblazers',
        team2: 'Cricrevo',
        matchType: 'League Match',
        venue: 'Noida Stadium',
        location: 'Noida',
        isLive: isLive,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LiveFeedScreen(),
            ),
          );
        },
      );
    },
  );
}

Widget _buildHighlightsList() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trailblazers vs Cricrevo - Match Highlights',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'League Match | Noida Stadium',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
}

