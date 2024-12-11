import 'package:flutter/material.dart';
class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: Center(child: const Text('Manage Habits Here')),
    );
  }
}