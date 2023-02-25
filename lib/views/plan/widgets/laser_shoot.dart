import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class LaseShoot extends StatefulWidget {
  double eixoX;
  double height;
  LaseShoot({Key? key, required this.eixoX, required this.height})
      : super(key: key);

  @override
  State<LaseShoot> createState() => _LaseShootState();
}

class _LaseShootState extends State<LaseShoot> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.only(left: size.width * .0155),
      child: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(
                widget.eixoX == 1.0
                    ? (widget.eixoX * 270.0)
                    : widget.eixoX == 200.0
                        ? widget.eixoX * 1.35
                        : widget.eixoX * -1.34,
                widget.height == 60.0 ? -120 : 0),
          child: Row(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateZ(widget.height == 60.0 ? 0.1: 0.2),
                child: CustomPaint(
                  painter: MyPainter(widget.height),
                  size: const Size.fromRadius(0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.width * .015),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateZ(widget.height == 60.0 ? -0.1 : -0.25),
                  child: CustomPaint(
                    painter: MyPainter(widget.height),
                    size: const Size.fromRadius(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double height;
  MyPainter(this.height);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment(0, 0),
        end: Alignment(5, 0),
        colors: [
          Colors.transparent,
          Colors.red,
          Colors.transparent,
        ],
      ).createShader(const Rect.fromLTWH(1, 0, 10, 1));
    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0), Offset(50, height == -60.0 ? (height * -1) * 1.5 : 200)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
