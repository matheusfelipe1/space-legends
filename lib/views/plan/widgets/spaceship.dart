import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/views/plan/widgets/cube.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';
import '../../../shared/models/orientation.dart';

class SpaceShip extends StatefulWidget {
  const SpaceShip({Key? key}) : super(key: key);

  @override
  State<SpaceShip> createState() => _SpaceShipState();
}

class _SpaceShipState extends State<SpaceShip> {

  final _blocSpaceShip = Modular.get<SpaceShipBloC>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 250,
        child: SizedBox(
            height: 450,
            width: 450,
            child: StreamBuilder<OrientationModel>(
                stream: _blocSpaceShip.streamOrientation,
                builder: (context, snapshot) {
                  double inclinacao = snapshot.data == null ? 1.0 : snapshot.data!.horizontal!;
                  double eixoX = inclinacao >= -0.2 && inclinacao <= 0.2
                      ? 1.0
                      : inclinacao > 0.2
                          ? 200.0
                          : -200.0;
                  double eixoY = snapshot.data == null ? 1.0 : snapshot.data!.vertical! >= 0.1 ? 60 : -60;
                  return AnimatedContainer(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.01)
                      ..translate(eixoX, eixoY),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn,
                    child: const CubeWidget(),
                  );
                })),
      ),
    );
  }
}
