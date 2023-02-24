import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/caveira2.jpeg',
            width: size.width * .2,
          ),
          const Center(
            child: Text(
              "Game Over",
              style: TextStyle(color: Colors.white, fontSize: 38),
            ),
          ),
          SizedBox(
            height: size.width * .02,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                     const Color.fromARGB(255, 201, 56, 45))),
              onPressed: () => Modular.to.pushReplacementNamed('/default/'),
              child: const Text('Try again',
                  style: TextStyle(color: Colors.white, fontSize: 19)))
        ],
      ),
    );
  }
}
