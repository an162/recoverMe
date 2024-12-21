import 'package:flutter/material.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Text('Activities Content Goes Here', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
