import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Suggested for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                height: 128,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SuggestionCard(title: 'Walk', duration: '10 km', color: Colors.orange),
                    SuggestionCard(title: 'Swim', duration: '30 min', color: Colors.blue),
                    SuggestionCard(title: 'Read', duration: '20 min', color: Colors.purple),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Challenges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChallengeCard(
                      title: 'Best Runners!',
                      timeLeft: '5 days 13 hours left',
                      onTap: () {},
                    ),
                    ChallengeCard(
                      title: 'Best Bikers!',
                      timeLeft: '2 days 11 hours left',
                      onTap: () {},
                    ),
                    ChallengeCard(
                      title: 'Strongest Lifters!',
                      timeLeft: '1 day 5 hours left',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Learning', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    LearningCard(
                      title: 'Why should we drink water often?',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailPage(title: 'Why should we drink water often?')),
                        );
                      },
                    ),
                    LearningCard(
                      title: 'Benefits of regular walking',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailPage(title: 'Benefits of regular walking')),
                        );
                      },
                    ),
                    LearningCard(
                      title: 'How to improve mental health',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailPage(title: 'How to improve mental health')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final String title;
  final String duration;
  final Color color;

  const SuggestionCard({required this.title, required this.duration, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.directions_walk, color: color, size: 30),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(duration, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final String title;
  final String timeLeft;
  final VoidCallback onTap;

  const ChallengeCard({required this.title, required this.timeLeft, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Container(
          width: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flag, color: Colors.white, size: 40),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Text(timeLeft, style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}

class LearningCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const LearningCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Container(
          width: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.book, color: Colors.white, size: 40),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Details about $title.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}