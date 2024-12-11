import 'package:flutter/material.dart';

class AchievementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('2 Achievements', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Best Runner!'),
            subtitle: Text('2 days ago'),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Best of the month!'),
            subtitle: Text('3 days ago'),
          ),
        ),
      ],
    );
  }
}