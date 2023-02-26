import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../blocs/enimies_bloc/enimies_bloC.dart';

class EnimeObj extends StatefulWidget {
  const EnimeObj({Key? key}) : super(key: key);

  @override
  State<EnimeObj> createState() => _EnimeObjState();
}

class _EnimeObjState extends State<EnimeObj> {
  late Timer periodic;
  final _bloCEnimies = Modular.get<EnimiesBloC>();

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
  }

  @override
  Widget build(BuildContext context) {
    return Cube(
      key: UniqueKey(),
      interactive: false,
      onSceneCreated: (scene) {
        scene.world.add(_bloCEnimies.enimies.obj!);
        scene.camera.zoom = 8;
      },
    );
  }
}
