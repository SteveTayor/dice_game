import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';

import '../dice.dart';

class DiceRollerGame extends StatefulWidget {
  @override
  _DiceRollerGameState createState() => _DiceRollerGameState();
}

class _DiceRollerGameState extends State<DiceRollerGame> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dices.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 80,
              left: 150,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    // Text(
                    //   'Dice Roller Game',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 23,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    ElevatedButton(
                      child: Text(
                        'Start Game',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DiceRollerScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
