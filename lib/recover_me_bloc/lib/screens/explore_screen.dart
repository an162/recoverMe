import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Text('Explore Content Goes Here', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
