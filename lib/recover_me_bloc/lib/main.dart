import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/habits_cubit.dart';
import 'cubits/sober_cubit.dart';  
import 'data/repositories/habit_repository.dart';
import 'database/database_helper.dart';
import 'package:recover_me_bloc/data/repositories/sober_repository..dart';
import 'screens/homepage.dart';
import 'screens/add_habit_page.dart';
import 'screens/explore_screen.dart';
import 'screens/profile_page.dart';
import 'screens/settings_page.dart';
import 'screens/achievements.dart';
import 'screens/sober_streak.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HabitsCubit(HabitRepository(DatabaseHelper())),
        ),
        BlocProvider(
          create: (_) => SoberCubit(SoberRepository(DatabaseHelper())),
        ),
      ],
      child: MaterialApp(
        title: 'RecoverMe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(userName: 'User', selectedAddiction: 'None'),
          '/addHabit': (context) => const AddHabitPage(),
          '/explore': (context) => const ExploreScreen(),
          '/profile': (context) => const ProfilePage(),
          '/settings': (context) => const SettingsPage(),
          
          // '/achievements': (context) => const AchievementsPage(),
          // '/soberStreak': (context) => const SoberStreakPage(currentStreak: 30), // Sample value
        },
      ),
    );
  }
}
