import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 1; // Default to Weekly
  DateTime _selectedDate = DateTime.now();
  final Map<String, dynamic> _data = {
    'Daily': {
      'successRate': '95%',
      'pointsEarned': '30',
      'completed': '20',
      'bestStreakDay': '3',
      'skipped': '1',
      'failed': '1',
      'graphData': [
        FlSpot(1, 1),
        FlSpot(2, 2),
        FlSpot(3, 3),
        FlSpot(4, 4),
        FlSpot(5, 5),
        FlSpot(6, 6),
        FlSpot(7, 7),
      ]
    },
    'Weekly': {
      'successRate': '98%',
      'pointsEarned': '322',
      'completed': '244',
      'bestStreakDay': '22',
      'skipped': '4',
      'failed': '2',
      'graphData': [
        FlSpot(1, 2),
        FlSpot(2, 3),
        FlSpot(3, 4),
        FlSpot(4, 5),
        FlSpot(5, 3.5),
        FlSpot(6, 4.5),
        FlSpot(7, 3),
      ]
    },
    'Monthly': {
      'successRate': '92%',
      'pointsEarned': '1200',
      'completed': '900',
      'bestStreakDay': '100',
      'skipped': '10',
      'failed': '5',
      'graphData': [
        FlSpot(1, 3),
        FlSpot(2, 4),
        FlSpot(3, 2),
        FlSpot(4, 3.5),
        FlSpot(5, 4),
        FlSpot(6, 5),
        FlSpot(7, 4.5),
      ]
    }
  };

  late AnimationController _animationController;
  late Animation<double> _animation;
  late CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.blueAccent,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation = Tween<double>(begin: 0, end: 1).animate(_curve);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    String selectedPeriod = _selectedIndex == 0 ? 'Daily' : _selectedIndex == 1 ? 'Weekly' : 'Monthly';
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo_mob.png')
,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Daily'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Weekly'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Monthly'),
                ),
              ],
              isSelected: [_selectedIndex == 0, _selectedIndex == 1, _selectedIndex == 2],
              onPressed: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: Icon(Icons.calendar_today),
              label: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 214, 211, 211),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Habits',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle, color: Colors.green),
                                        SizedBox(width: 4),
                                        Text('Success Rate: ${_data[selectedPeriod]['successRate']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber),
                                        SizedBox(width: 4),
                                        Text('Points Earned: ${_data[selectedPeriod]['pointsEarned']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.done, color: Colors.blue),
                                        SizedBox(width: 4),
                                        Text('Completed: ${_data[selectedPeriod]['completed']}'),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.local_fire_department, color: Colors.red),
                                        SizedBox(width: 4),
                                        Text('Best Streak Day: ${_data[selectedPeriod]['bestStreakDay']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.remove_circle, color: Colors.orange),
                                        SizedBox(width: 4),
                                        Text('Skipped: ${_data[selectedPeriod]['skipped']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.cancel, color: Colors.redAccent),
                                        SizedBox(width: 4),
                                        Text('Failed: ${_data[selectedPeriod]['failed']}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Habits',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 200,
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(show: false),
                                  titlesData: FlTitlesData(
                                    show: false,
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List<FlSpot>.from(_data[selectedPeriod]['graphData']),
                                      isCurved: true,
                                      color: Colors.blue,
                                      barWidth: 4,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        color: Colors.blue.withOpacity(0.3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}