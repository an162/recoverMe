import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/screens/create_account_screen.dart';
import 'package:project/screens/dashboard_screen.dart';
import 'package:project/screens/choose_addiction_screen.dart';
import 'package:project/screens/forgot_password_screen.dart';
import 'package:project/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if onboarding has been completed
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/chooseAddiction': (context) => ChooseAddictionScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/onboarding': (context) => OnboardingScreen(),
      },
      initialRoute: isFirstTime ? '/onboarding' : '/login',
    );
  }
}
