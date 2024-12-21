import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Text('Profile Content Goes Here', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
