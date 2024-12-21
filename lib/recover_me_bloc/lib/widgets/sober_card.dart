import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recover_me_bloc/cubits/sober_cubit.dart';
import 'package:recover_me_bloc/screens/sober_streak.dart';

class SoberCard extends StatelessWidget {
  final int soberDays;

  const SoberCard({Key? key, required this.soberDays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          'Sober Days: $soberDays',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: soberDays >= 30
            ? Text('🎉 Congratulations on reaching 30 days!')
            : null,
        onTap: () {
          if (soberDays >= 30) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoberStreakPage(currentStreak: soberDays),
              ),
            );
          }
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read<SoberCubit>().updateSoberDays(soberDays + 1);
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                context.read<SoberCubit>().resetSoberDays();
              },
            ),
          ],
        ),
      ),
    );
  }
}
