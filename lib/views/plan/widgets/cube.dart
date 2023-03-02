import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';

class CubeWidget extends StatefulWidget {
  const CubeWidget({Key? key}) : super(key: key);

  @override
  State<CubeWidget> createState() => _CubeWidgetState();
}

class _CubeWidgetState extends State<CubeWidget> {
  final _blocSpaceShip = Modular.get<SpaceShipBloC>();
  final _blocCombat = Modular.get<CombatBloC>();
  final _key = GlobalKey();
  late Timer timer;
  late StreamSubscription _subs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocSpaceShip.space.obj =
        Object(fileName: 'assets/cube/Intergalactic_Spaceship-(Wavefront).obj');
    _blocSpaceShip.space.obj!.transform
      ..setEntry(3, 2, 0.01)
      ..rotateX(-0.7);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getMyPosition();
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _subs.cancel();
    // timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Cube(
        key: _key,
        interactive: false,
        onSceneCreated: (scene) {
          scene.world.add(_blocSpaceShip.space.obj!);
          scene.camera.zoom = 8;
        },
      ),
    );
  }

  _getMyPosition() {
    _subs = _blocCombat.periodc.listen((event) {
      if (_blocCombat.canShoot && !_blocCombat.killed) {
        RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        _blocCombat.inputOffset.add(position);
      }
    });
  }
}
