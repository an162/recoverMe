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

  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();

  // Determine initial screen
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Set the initial route
  String initialRoute;
  if (isFirstTime) {
    initialRoute = '/onboarding';
  } else if (isLoggedIn) {
    initialRoute = '/dashboard';
  } else {
    initialRoute = '/login';
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});

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
      initialRoute: initialRoute,
    );
  }
}
