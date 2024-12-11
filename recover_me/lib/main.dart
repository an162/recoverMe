import 'package:flutter/material.dart';
import 'package:recover_me/activity_list.dart';
import 'homepage.dart';
import 'addictions_page.dart';
import 'habits_page.dart';
import 'profile_page.dart';
import 'add_habit_page.dart';
import 'choose_addiction_screen.dart';
import 'create_account_screen.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'package:recover_me/settings_page.dart';
import 'activities.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecoverMe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(
              userName: '',
              selectedAddiction: '',
            ),
        '/addictions': (context) => const AddictionsPage(),
        '/habits': (context) => const HabitsPage(),
        '/profile': (context) =>  ProfilePage(),
        '/login': (context) => LoginScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/chooseAddiction': (context) => ChooseAddictionScreen(),
        '/add_habit_page': (context) => const AddHabitPage(),
        '/onboardingScreen': (context) => OnboardingScreen(),
                '/settings': (context) => SettingsPage(),
                        '/activities': (context) => ActivityScreen(),


      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboardingScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
