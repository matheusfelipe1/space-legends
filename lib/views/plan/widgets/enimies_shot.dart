import 'package:flutter/material.dart';

class EnimiesShot extends StatefulWidget {
  const EnimiesShot({Key? key}) : super(key: key);

  @override
  State<EnimiesShot> createState() => _EnimiesShotState();
}

class _EnimiesShotState extends State<EnimiesShot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: CustomPaint(
        painter: MyPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // TODO: implement paint
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.transparent,
          const Color.fromARGB(255, 221, 33, 140).withOpacity(0.9),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset.zero,
        radius: 25,
      ));
    canvas.drawArc(
        Rect.fromPoints(const Offset(0.0, 0.0), const Offset(10.0, 40.0)),
        0.0,
        90.0,
        true,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
