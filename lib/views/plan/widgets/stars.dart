import 'dart:math';

import 'package:flutter/material.dart';

class StarsComponent extends StatefulWidget {
  const StarsComponent({Key? key}) : super(key: key);

  @override
  State<StarsComponent> createState() => _StarsComponentState();
}

class _StarsComponentState extends State<StarsComponent> {
  final _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    teste();
    final d = Random().nextDouble();
    return Container(
      key: _key,
      child: PositionedCustom(
          Random().nextInt(35),
          CircleAvatar(
            radius: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(d <= 0.5 ? 1 : d),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )),
    );
  }
  bool valid = false;

  double get getNextDouble => Random().nextInt(1000).toDouble();

  // ignore: non_constant_identifier_names
  Widget PositionedCustom(int param, Widget child) {
    if (param > 0 && param <= 5) {
      return AnimatedPositioned(
          duration: const Duration(seconds: 2),
          child: child,
          top: valid ? getNextDouble : getNextDouble * 0.0 ,
          left: valid ? getNextDouble : getNextDouble * 0.0);
    } else if (param > 5 && param <= 10) {
      return Positioned(
          child: child,
          bottom: getNextDouble,
          left: getNextDouble);
    } else if (param > 10 && param <= 15) {
      return Positioned(child: child, top: getNextDouble, right: getNextDouble);
    } else if (param > 15 && param <= 20) {
      return Positioned(
          child: child, bottom: getNextDouble, right: getNextDouble);
    } else if (param > 20 && param <= 25) {
      return Positioned(
        child: child,
        right: getNextDouble,
        bottom: getNextDouble * 0.1,
      );
    } else {
      return Container();
    }
  }


  teste() {
    Future.delayed(const Duration(milliseconds: 2000),() {
      setState(() {
        valid = !valid;
      });
    });
  }
}
