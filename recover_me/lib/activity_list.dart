import 'package:flutter/material.dart';
import 'activity.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;

  ActivityList({required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: activities.map((activity) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              '${activity.points} points earned',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${activity.date.day}/${activity.date.month}/${activity.date.year}'),
          ),
        );
      }).toList(),
    );
  }
}