
import 'package:flutter/material.dart';
import 'dart:math';
class HabitGoalReachedPage extends StatefulWidget {
  final int goal;
  final int currentStreak;
  final VoidCallback onContinue;
  const HabitGoalReachedPage({
    Key? key,
    required this.goal,
    required this.currentStreak,
    required this.onContinue,
  }) : super(key: key);
  @override
  _HabitGoalReachedPageState createState() => _HabitGoalReachedPageState();
}
class _HabitGoalReachedPageState extends State<HabitGoalReachedPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE082), Color(0xFFFFD54F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: GlitterPainter(_controller.value),
                child: Container(),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 100,
                      color: Color.fromRGBO(255, 160, 0, 1), 
                ),
                const SizedBox(height: 20),
               
                const SizedBox(height: 20),
                Text(
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You just reached a new habit goal!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'This badge is a symbol of your commitment to yourself. Keep going and earn more badges along the way.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color:  Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: widget.onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class GlitterPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random();
  GlitterPainter(this.animationValue);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.6);
    final sparkleCount = 50;
    for (int i = 0; i < sparkleCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 4 + 2;
      final pulsingEffect = (animationValue + i / sparkleCount) % 1.0;
      final opacity = (1.0 - pulsingEffect).clamp(0.0, 1.0);
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }
  @override
  bool shouldRepaint(covariant GlitterPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}