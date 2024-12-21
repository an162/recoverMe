import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Text('Settings Content Goes Here', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
