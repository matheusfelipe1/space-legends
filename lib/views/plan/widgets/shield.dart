import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';
import '../../../shared/models/orientation.dart';

class Shield extends StatefulWidget {
  const Shield({Key? key}) : super(key: key);

  @override
  State<Shield> createState() => _ShieldState();
}

class _ShieldState extends State<Shield> {
  final _blocSpaceShip = Modular.get<SpaceShipBloC>();
  @override
  Widget build(BuildContext context) {
    return Container(
            key: UniqueKey(),
      child: StreamBuilder<OrientationModel>(
            key: UniqueKey(),
          stream: _blocSpaceShip.streamOrientation,
          builder: (context, snapshot) {
            double inclinacao =
                snapshot.data == null ? 1.0 : snapshot.data!.horizontal!;
            double eixoX = inclinacao >= -0.2 && inclinacao <= 0.2
                ? 1.0
                : inclinacao > 0.2
                    ? 200.0
                    : -200.0;
            double eixoY = snapshot.data == null
                ? 1.0
                : snapshot.data!.vertical! >= 0.1
                    ? 60
                    : -60;
            return AnimatedContainer(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..translate(eixoX, eixoY),
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              child: CustomPaint(
                key: UniqueKey(),
                painter: MyPainter(),
                size: const Size.fromRadius(34),
              ),
            );
          }),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          Colors.blue.withOpacity(0.8),
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromPoints(
        Offset(size.height * -1, size.width),
        const Offset(200, 150)
      ));
    canvas.drawRect(Offset(size.height * -1, size.width) & const Size(200, 150), paint);
    // canvas.drawArc(
    //   Rect.fromCenter(
    //     center: Offset(size.height / 2, size.width / 2),
    //     height: size.height,
    //     width: size.width,
    //   ),
    //   pi,
    //   pi,
    //   false,
    //   paint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
