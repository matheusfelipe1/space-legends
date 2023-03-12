import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BufferingScreen extends StatefulWidget {
  const BufferingScreen({Key? key}) : super(key: key);

  @override
  State<BufferingScreen> createState() => _BufferingScreenState();
}

class _BufferingScreenState extends State<BufferingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 1500), () => Modular.to.pushReplacementNamed('/game/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset('assets/images/f2.jpeg', fit: BoxFit.cover),
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.85)),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(
                  width: 25,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
