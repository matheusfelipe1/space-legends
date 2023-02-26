import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/shared/models/spaceship.dart';
import 'package:space_legends/views/plan/widgets/cube.dart';
import 'package:space_legends/views/plan/widgets/laser_shoot.dart';
import 'package:space_legends/views/plan/widgets/shield.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';
import '../../../shared/models/orientation.dart';
import 'aim.dart';

class SpaceShip extends StatefulWidget {
  const SpaceShip({Key? key}) : super(key: key);

  @override
  State<SpaceShip> createState() => _SpaceShipState();
}

class _SpaceShipState extends State<SpaceShip> {
  final _blocSpaceShip = Modular.get<SpaceShipBloC>();
  bool showShield = false;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              key: UniqueKey(),
              child: StreamBuilder<SpaceShipModel>(
                  stream: _blocSpaceShip.stream,
                  builder: (context, snapshot) {
                    return snapshot.data == null || !snapshot.data!.showShield!
                        ? const Aim()
                        : const SizedBox();
                  })),
          Container(
            key: UniqueKey(),
            child: StreamBuilder<SpaceShipModel>(
                stream: _blocSpaceShip.stream,
                builder: (context, snapshot) {
                  return snapshot.data != null && snapshot.data!.showShield!
                      ? const Shield()
                      : const SizedBox();
                }),
          ),
          SizedBox(
            width: 600,
            height: 200,
            child: SizedBox(
              width: 200,
              height: 200,
              child: StreamBuilder<OrientationModel>(
                  stream: _blocSpaceShip.streamOrientation,
                  builder: (context, snapshot) {
                    double inclinacao = snapshot.data == null
                        ? 1.0
                        : snapshot.data!.horizontal!;
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
                      height: 200,
                      width: 200,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..translate(eixoX, eixoY),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastOutSlowIn,
                      child: Stack(
                        children: [
                          const CubeWidget(),
                          if (!showShield)
                            Positioned(
                              top: 0,
                              child: LaseShoot(
                                eixoX: eixoX,
                                height: eixoY,
                                aimPosition: -35,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
