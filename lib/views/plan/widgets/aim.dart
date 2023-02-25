
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';
import '../../../shared/models/orientation.dart';

class Aim extends StatefulWidget {
  const Aim({Key? key}) : super(key: key);

  @override
  State<Aim> createState() => _AimState();
}

class _AimState extends State<Aim> {
  final _blocSpaceShip = Modular.get<SpaceShipBloC>();
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.only(right: size.width * .006),
      child: StreamBuilder<OrientationModel>(
          stream: _blocSpaceShip.streamOrientation,
          builder: (context, snapshot) {
            double inclinacao =
                snapshot.data == null ? 1.0 : snapshot.data!.horizontal!;
            double eixoX = inclinacao >= -0.2 && inclinacao <= 0.2
                ? 1.0
                : inclinacao > 0.2
                    ? 200.0
                    : -200.0;
            return AnimatedContainer(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..translate(eixoX, -35),
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              width: 20,
              height: 20,
              child: CustomPaint(
                key: _key,
                painter: MyPainter(),
                size: const Size.fromRadius(0),
              ),
            );
          }),
    );
  }

}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint2 = Paint()..color = Colors.white;
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.transparent,
          Colors.white.withOpacity(0.9),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset.zero,
        radius: 25,
      ));
    canvas.drawCircle(Offset.zero, 20, paint);
    canvas.drawLine(const Offset(0, -20), const Offset(0, 20), paint2);
    canvas.drawLine(const Offset(20, 0), const Offset(-20, 0), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
