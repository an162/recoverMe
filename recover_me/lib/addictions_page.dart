import 'package:flutter/material.dart';

class AddictionsPage extends StatelessWidget {
  const AddictionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Addictions')),
      body: Center(child: const Text('Manage Addictions Here')),
    );
  }
}