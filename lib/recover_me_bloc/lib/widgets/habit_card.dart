
import 'package:flutter/material.dart';
class HabitCard extends StatelessWidget {
  final String name;
  final int current;
  final int target;
  final VoidCallback onIncrement;
  final VoidCallback onDelete;
  const HabitCard({
    Key? key,
    required this.name,
    required this.current,
    required this.target,
    required this.onIncrement,
    required this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Current: $current / Target: $target'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: current >= target ? null : onIncrement, 
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}