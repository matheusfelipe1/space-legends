import 'package:flutter/material.dart';

class BufferingGame extends StatelessWidget {
  const BufferingGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            'Carregando..',
            style: TextStyle(color: Colors.white, fontSize: 21),
          )
        ],
      )),
    );
  }
}
