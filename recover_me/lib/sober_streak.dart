
import 'package:flutter/material.dart';
import 'dart:math';
class SoberStreakPage extends StatefulWidget {
  final int currentStreak;
  const SoberStreakPage({Key? key, required this.currentStreak}) : super(key: key);
  @override
  _SoberStreakPageState createState() => _SoberStreakPageState();
}
class _SoberStreakPageState extends State<SoberStreakPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
      backgroundColor: const Color(0xFFFFD54F), // Set the background color to the golden-orange
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: FireworksPainter(_controller.value),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Icon(
                      Icons.emoji_events, 
                      size: 120,
                      color: Colors.amber.shade700, 
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Congrats!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'You’ve hit your monthly streak sober!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'This badge is a symbol of your commitment to yourself. Keep going and earn more badges along the way.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF), 
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class FireworksPainter extends CustomPainter {
  final double progress;
  FireworksPainter(this.progress);
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint = Paint()..style = PaintingStyle.stroke;
    for (int i = 0; i < 7; i++) {
      final centerX = size.width * random.nextDouble();
      final centerY = size.height * random.nextDouble();
      for (int j = 0; j < 15; j++) {
        final angle = 2 * pi * random.nextDouble();
        final distance = 50 + 100 * progress; // Expanding outward
        final sparkleX = centerX + cos(angle) * distance;
        final sparkleY = centerY + sin(angle) * distance;
        paint.color = Colors.yellowAccent.withOpacity(1 - progress);
        paint.strokeWidth = 2;
        canvas.drawLine(
          Offset(sparkleX - 5, sparkleY),
          Offset(sparkleX + 5, sparkleY),
          paint,
        );
        canvas.drawLine(
          Offset(sparkleX, sparkleY - 5),
          Offset(sparkleX, sparkleY + 5),
          paint,
        );
      }
    }
  }
  @override
  bool shouldRepaint(covariant FireworksPainter oldDelegate) => true;
}