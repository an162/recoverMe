import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recover_me_bloc/cubits/habits_cubit.dart';
import 'package:recover_me_bloc/cubits/sober_cubit.dart';
import 'package:recover_me_bloc/widgets/habit_card.dart';
import 'package:recover_me_bloc/widgets/side_drawer.dart';
import 'package:recover_me_bloc/widgets/sober_card.dart'; 
import 'package:recover_me_bloc/screens/achievements.dart'; 

import 'add_habit_page.dart';
import 'explore_screen.dart';
import 'settings_page.dart';
import 'profile_page.dart';

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
  late String _userName;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    context.read<HabitsCubit>().fetchHabits(); 
    context.read<SoberCubit>().fetchSoberDays(); 
  }

  void _incrementHabit(int id, int current, int target) {
    context.read<HabitsCubit>().updateHabit(id, current + 1);
  }

  void _deleteHabit(int id) {
    context.read<HabitsCubit>().deleteHabit(id);
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ExploreScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => AchievementsPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
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
        backgroundColor: Color.fromARGB(255, 6, 65, 129),
        elevation: 4.0,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $_userName',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            BlocBuilder<SoberCubit, SoberState>(
              builder: (context, state) {
                if (state is SoberLoaded) {
                  return SoberCard(soberDays: state.soberDays);
                } else if (state is SoberError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),

            SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<HabitsCubit, HabitsState>(
                builder: (context, state) {
                  if (state is HabitsLoaded) {
                    final habits = state.habits;
                    return ListView.builder(
                      itemCount: habits.length,
                      itemBuilder: (context, index) {
                        final habit = habits[index];
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
                    );
                  } else if (state is HabitsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HabitsError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
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
            MaterialPageRoute(builder: (_) => AddHabitPage()),
          ).then((_) => context.read<HabitsCubit>().fetchHabits());
        },
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Container(), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Achievements'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
