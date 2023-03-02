import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/shared/models/spaceship.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';

class LaseShoot extends StatefulWidget {
  double eixoX;
  double height;
  double aimPosition;
  LaseShoot(
      {Key? key,
      required this.eixoX,
      required this.height,
      required this.aimPosition})
      : super(key: key);

  @override
  State<LaseShoot> createState() => _LaseShootState();
}

class _LaseShootState extends State<LaseShoot> {
  final _blocSpaceShip = Modular.get<SpaceShipBloC>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<SpaceShipModel>(
        stream: _blocSpaceShip.stream,
        builder: (context, snapshot) {
          bool showShot =
              snapshot.data == null ? false : snapshot.data!.iShot!;
          return AnimatedOpacity(
            opacity: showShot ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 700),
            child: Container(
              key: UniqueKey(),
              margin: EdgeInsets.only(right: size.width * .0169),
              child: Center(
                key: UniqueKey(),
                child: AnimatedContainer(
                  key: UniqueKey(),
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(
                        widget.eixoX == 1.0
                            ? (widget.eixoX * 270.0)
                            : widget.eixoX == 200.0
                                ? widget.eixoX * 1.35
                                : widget.eixoX * -1.34,
                        0.0),
                  child: Row(
                    key: UniqueKey(),
                    children: [
                      AnimatedContainer(
                        key: UniqueKey(),
                        duration: const Duration(milliseconds: 500),
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                              widget.height == -60.0 ? -0.1 : 1.0,
                              showShot
                                  ? widget.aimPosition * 3.5
                                  : widget.height == -60.0
                                      ? 30
                                      : 50)
                          ..rotateZ(0.1),
                        child: CustomPaint(
                          painter: MyPainter(widget.height),
                          size: const Size.fromRadius(0),
                        ),
                      ),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: !showShot
                              ? widget.height != 60.0
                                  ? 0
                                  : 30
                              : 0),
                      Container(
                        margin: EdgeInsets.only(top: size.width * .010),
                        child: AnimatedContainer(
                          key: UniqueKey(),
                          duration: const Duration(milliseconds: 500),
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                                1.0,
                                showShot
                                    ? widget.aimPosition * 3.5
                                    : widget.height == -60.0
                                        ? -5
                                        : 50)
                            ..rotateZ(-0.1),
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
            ),
          );
        });
  }
}

class MyPainter extends CustomPainter {
  double height;
  MyPainter(this.height);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..shader = height == -60
          ? const RadialGradient(colors: [
              Colors.yellow,
              Colors.transparent,
            ]).createShader(
              Rect.fromCircle(center: const Offset(18, 5), radius: 18))
          : const LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(5, 0),
              colors: [
                Colors.transparent,
                Colors.red,
                Colors.transparent,
              ],
            ).createShader(const Rect.fromLTWH(1, 0, 10, 1));
    height == -60
        ? canvas.drawCircle(const Offset(18, 5), 10, paint)
        : canvas.drawRect(
            Rect.fromPoints(const Offset(0, 0), const Offset(50, 20)
                // height == -60.0 ? (height * -1) * 1.5 : 200)
                ),
            paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
