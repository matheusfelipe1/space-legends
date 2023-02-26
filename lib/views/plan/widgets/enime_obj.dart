import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';
import 'package:space_legends/shared/models/combat.dart';

import '../../../blocs/enimies_bloc/enimies_bloC.dart';

class EnimeObj extends StatefulWidget {
  const EnimeObj({Key? key}) : super(key: key);

  @override
  State<EnimeObj> createState() => _EnimeObjState();
}

class _EnimeObjState extends State<EnimeObj> {
  late Timer periodic;
  final _bloCEnimies = Modular.get<EnimiesBloC>();
  final _bloCCombat = Modular.get<CombatBloC>();
  final _key = GlobalKey();
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloCEnimies.enimies.obj = Object(fileName: 'assets/cube/Low_poly_UFO.obj');
    periodic = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _bloCEnimies.enimies.obj!.transform
        ..setEntry(3, 2, 0.01)
        ..rotateY(0.7);
    });
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), () {
        _listening();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Cube(
      key: _key,
      interactive: false,
      onSceneCreated: (scene) {
        scene.world.add(_bloCEnimies.enimies.obj!);
        scene.camera.zoom = 8;
      },
    );
  }

  Offset? _getEnimyPosition() {
    if (_key.currentContext == null) return null;
    RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    return position;
  }

  _listening() {
    _bloCCombat.outputOffset.listen((event) async {
      Offset my = event;
      Offset? enimy = _getEnimyPosition();
    
      if (enimy != null) {
        if (_bloCCombat.isFinish) {
          enimy = Offset(enimy.dx, -150.0);
          _bloCCombat.inputCombat
              .add(CombatModel(fromMe: false, myCoordinates: enimy));
        } else {
          _bloCCombat.inputCombat
              .add(CombatModel(fromMe: true, myCoordinates: my));
        }
        _bloCCombat.newCompleter;
      }
    });
  }
}
