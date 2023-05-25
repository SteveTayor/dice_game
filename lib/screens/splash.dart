import 'dart:async';
import 'package:flutter/material.dart';

import '../home/dice_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _timer; // Add Timer variable

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    _timer = Timer(const Duration(seconds: 10), () => _navigateToHome(context));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel(); // Cancel the timer if it is still active
    super.dispose();
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiceRollerGame()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dices.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 80,
              left: 40,
              child: Text(
                'Dice \nRoller Game',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 50,
              left: 150,
              child: const Text(
                'Free and fun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
