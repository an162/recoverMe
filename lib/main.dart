import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'blocs/create_account/create_account_bloc.dart'; // Import the CreateAccountBloc
import 'database/database_helper.dart';
import 'screens/login_screen.dart';
import 'package:project/screens/create_account_screen.dart';
import 'package:project/screens/dashboard_screen.dart';
import 'package:project/screens/choose_addiction_screen.dart';
import 'package:project/screens/forgot_password_screen.dart';
import 'package:project/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DBHelper.instance;

  runApp(MyApp(dbHelper: dbHelper));
}

class MyApp extends StatelessWidget {
  final DBHelper dbHelper;

  const MyApp({required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(dbHelper: dbHelper),
        ),
        BlocProvider<CreateAccountBloc>( // Add the CreateAccountBloc here
          create: (context) => CreateAccountBloc(dbHelper: dbHelper),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginScreen(),
          '/createAccount': (context) => CreateAccountScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/chooseAddiction': (context) => ChooseAddictionScreen(email: ''),
          '/forgotPassword': (context) => ForgotPasswordScreen(),
          '/onboarding': (context) => OnboardingScreen(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
