
import 'package:flutter/material.dart';
import 'package:recover_me/achievements.dart';
import 'package:recover_me/database_helper.dart';
import 'package:recover_me/habit_card.dart';
import 'package:recover_me/profile_page.dart';
import 'package:recover_me/side_drawer.dart';
import 'add_habit_page.dart';
import 'habit_goal_reached.dart';
import 'package:recover_me/settings_page.dart';
import 'package:recover_me/sober_streak.dart';
import 'activities.dart';
import 'explore_screen.dart';
class HomePage extends StatefulWidget {
  final String userName; 
  final String selectedAddiction;
  const HomePage({
    Key? key,
    required this.userName,
    required this.selectedAddiction,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _habits = [];
  int _soberDays = 0;
  late String _userName;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    _loadHabits();
    _loadSoberDays();
  }
  Future<void> _loadHabits() async {
    final data = await _dbHelper.getHabits();
    setState(() {
      _habits = data;
    });
  }
  Future<void> _loadSoberDays() async {
    final soberDays = await _dbHelper.getSoberDays();
    setState(() {
      _soberDays = soberDays;
    });
  }
  void _incrementHabit(int id, int current, int target) async {
    if (current >= target) return;
    final newCurrent = current + 1;
    await _dbHelper.updateHabit(id, newCurrent);
    if (newCurrent == target) {
      final habit = _habits.firstWhere((habit) => habit['id'] == id);
      await _dbHelper.insertAchievement(habit['habit_name']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HabitGoalReachedPage(
            goal: target,
            currentStreak: newCurrent,
            onContinue: () {
              _loadHabits();
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      _loadHabits();
    }
  }
  void _incrementSoberDays() async {
    int currentSoberDays = await _dbHelper.getSoberDays();
    int newSoberDays = currentSoberDays + 1;
    setState(() {
      _soberDays = newSoberDays;
    });
    await _dbHelper.updateSoberDays(newSoberDays);
    _loadSoberDays();
    if (newSoberDays >= 30) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SoberStreakPage(currentStreak: newSoberDays),
        ),
      );
    }
  }
  Future<void> _deleteHabit(int id) async {
    await _dbHelper.deleteHabit(id);
    _loadHabits();
  }
  void _resetSoberDays() {
    setState(() {
      _soberDays = 0;
    });
    _dbHelper.updateSoberDays(0);
  }
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ExploreScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AchievementsPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ProfilePage()),
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text(
    'RecoverMe',
    style: TextStyle(
      fontSize: 24, 
      fontWeight: FontWeight.bold,
      color: Colors.white, 
      fontFamily: 'DancingScript', 
      letterSpacing: 1.5, 
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 6, 65, 129),
  elevation: 4.0,
),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome $_userName 😊',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Your journey of self-improvement starts here!',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(
                  'Days Sober: $_soberDays',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Color.fromARGB(255, 157, 76, 175)),
                      onPressed: _incrementSoberDays,
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Color.fromARGB(255, 9, 54, 133)),
                      onPressed: _resetSoberDays,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Habits:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  final habit = _habits[index];
                  return HabitCard(
                    name: habit['habit_name'],
                    current: habit['current_value'],
                    target: habit['target_value'],
                    onIncrement: () => _incrementHabit(
                      habit['id'],
                      habit['current_value'],
                      habit['target_value'],
                    ),
                    onDelete: () => _deleteHabit(habit['id']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitPage()),
          ).then((_) => _loadHabits());
        },
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.emoji_events),
            label: 'Achievements',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}