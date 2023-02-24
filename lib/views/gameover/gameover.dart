import 'package:flutter/material.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({ Key? key }) : super(key: key);

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text("Game Over"),
      ),
    );
  }
}