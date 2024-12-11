import 'package:flutter/material.dart';
import 'activity.dart';
import 'activity_list.dart';
import 'achievement_list.dart';
import 'settings_page.dart';

class ProfileActivityScreen extends StatefulWidget {
  @override
  _ProfileActivityScreenState createState() => _ProfileActivityScreenState();
}

class _ProfileActivityScreenState extends State<ProfileActivityScreen> {
  bool isActivityScreen = true;
  String selectedMonth = 'January';

  // Sample activities data
  final List<Activity> activities = [
    Activity(points: 112, date: DateTime(2023, 1, 12), description: 'points earned'),
    Activity(points: 62, date: DateTime(2023, 1, 10), description: 'points earned'),
    Activity(points: 96, date: DateTime(2023, 1, 11), description: 'points earned'),
    Activity(points: 110, date: DateTime(2022, 2, 10), description: 'points earned'),
    Activity(points: 150, date: DateTime(2022, 12, 1), description: 'Challenge completed!'),
  ];

  void toggleScreen() {
    setState(() {
      isActivityScreen = !isActivityScreen;
    });
  }

  List<Activity> filterActivities(String month) {
    final monthIndex = _getMonthIndex(month);
    return activities.where((activity) => activity.date.month == monthIndex).toList();
  }

  int _getMonthIndex(String month) {
    switch (month) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        return 1;
    }
  }

  void selectMonth(String month) {
    setState(() {
      selectedMonth = month;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Profile Header
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User 01',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '1,460 Points',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Settings Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: toggleScreen,
                      child: Text('Activity'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, 
                        backgroundColor: isActivityScreen ? Colors.blue : Colors.grey[300],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: toggleScreen,
                      child: Text('Achievements'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, 
                        backgroundColor: isActivityScreen ? Colors.grey[300] : Colors.blue,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.tune, color: Colors.grey),
                      onSelected: selectMonth,
                      itemBuilder: (BuildContext context) {
                        return [
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December',
                        ].map((String month) {
                          return PopupMenuItem<String>(
                            value: month,
                            child: Text(month),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Activity or Achievements List
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: isActivityScreen
                  ? ActivityList(activities: filterActivities(selectedMonth))
                  : AchievementList(),
            ),
          ),
        ],
      ),
    );
  }
}