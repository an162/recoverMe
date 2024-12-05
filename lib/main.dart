import 'package:flutter/material.dart';
import 'package:project/screens/choose_addiction_screen.dart';
import 'package:project/screens/create_account_screen.dart';
import 'package:project/screens/dashboard_screen.dart';
import 'package:project/screens/login_screen.dart'; 
import 'package:project/screens/forgot_password_screen.dart'; 
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
        '/dashboard': (context) => DashboardScreen(), 
        "/chooseAddiction": (context) => ChooseAddictionScreen(),
          '/forgotPassword': (context) => ForgotPasswordScreen(),
      },
      initialRoute: '/login',
    );
  }
}
