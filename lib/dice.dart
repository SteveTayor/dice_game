import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:share/share.dart';

import 'providers/audio_settings_providers.dart';
import 'providers/settings_providers.dart';
import 'settings.dart';

class DiceRollerScreen extends StatefulWidget {
  @override
  _DiceRollerScreenState createState() => _DiceRollerScreenState();
}

class _DiceRollerScreenState extends State<DiceRollerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dieXPosition = 0.0;
  double _dieYPosition = 0.0;
  int _diceValue1 = 1;
  int _diceValue2 = 1;
  int _score = 0;
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          _dieXPosition = 100 * _animation.value;
          _dieYPosition = -150 * _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _diceValue1 = generateRandomDiceValue();
            _diceValue2 = generateRandomDiceValue();
            _score = _diceValue1 + _diceValue2;
            if (_score > _highScore) {
              _highScore = _score;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Congratulations!!'),
                    titlePadding: const EdgeInsets.only(
                      left: 18,
                      bottom: 28,
                      top: 18,
                    ),
                    content: Text(
                      'You got a new High Score $_highScore',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              );
              _playHighScoreSound();
            }
          });
          _animationController.reset();
          _playDiceRollSound();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _rollDice() {
    if (_animationController.isAnimating) return;
    setState(() {
      _score = 0;
    });
    _animationController.forward();
  }

  void _resetGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Game'),
          content: const Text('Are you sure you want to reset the game?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Reset'),
              onPressed: () {
                setState(() {
                  _score = 0;
                  _diceValue1 = generateRandomDiceValue();
                  _diceValue2 = generateRandomDiceValue();
                  _highScore = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int generateRandomDiceValue() {
    return Random().nextInt(6) + 1;
  }

  Color highscoreColor() {
    final themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return themeMode == ThemeMode.dark ? Colors.white : Colors.black;
  }

  void _playDiceRollSound() async {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.enableAudio) {
      final player = AudioPlayer();
      await player.setAsset('assets/audio/rolling_dice.mp3');
      await player.play();
      // Check if the audio file is playing
      if (player.playing) {
        print('Audio playback started successfully.');
      } else {
        print('Failed to start audio playback.');
      }
    }
  }

  void _playHighScoreSound() async {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.enableAudio) {
      final player2 = AudioPlayer();
      await player2.setAsset('assets/audio/success2.wav');
      await player2.play();
      // Check if the audio file is playing
      if (player2.playing) {
        print('Audio playback started successfully.');
      } else {
        print('Failed to start audio playback.');
      }
    }
  }

  void _shareScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share Score'),
          content: const Text('Share your score with friends'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Share'),
              onPressed: () {
                Navigator.of(context).pop();
                _executeShare();
              },
            ),
          ],
        );
      },
    );
  }

  void _executeShare() {
    Share.share('My High score in Dice Roller Game is $_highScore');
  }

  void _openSettingsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? 'assets/images/black.jpg'
            : 'assets/images/SL.jpg';
    return SafeArea(
            child: Scaffold(
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: _rollDice,
                    child: Stack(
                      children: [
                        Image.asset(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.settings),
                                onPressed: _openSettingsScreen,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, bottom: 80),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: _shareScore,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Your Score: $_score',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Transform.rotate(
                                        angle: _animation.value * 0.5 * pi,
                                        child: Image.asset(
                                          'assets/images/dice_$_diceValue1.png',
                                          width: constraints.maxWidth * 0.3,
                                          height: constraints.maxWidth * 0.3,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Transform.rotate(
                                        angle: _animation.value * 0.5 * pi,
                                        child: Image.asset(
                                          'assets/images/dice_$_diceValue2.png',
                                          width: constraints.maxWidth * 0.3,
                                          height: constraints.maxWidth * 0.3,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 18.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'High Score: $_highScore',
                              style: TextStyle(
                                color: highscoreColor(),
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: _resetGame,
              ),
            ),
          );
  }
}
