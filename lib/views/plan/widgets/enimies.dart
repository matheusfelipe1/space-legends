import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Enimies extends StatefulWidget {
  const Enimies({ Key? key }) : super(key: key);

  @override
  State<Enimies> createState() => _EnimiesState();
}

class _EnimiesState extends State<Enimies> {
  Object obj = Object(fileName: 'assets/cube/Low_poly_UFO.obj');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  _startGame() {
    obj.transform..setEntry(3, 2, 0.01)..rotateY(0.7);
  }
  @override
  Widget build(BuildContext context) {
    return Cube(
      key: UniqueKey(),
      interactive: false,
      onSceneCreated: (scene) {
        scene.world.add(obj);
        scene.camera.zoom = 8;
      },
      onObjectCreated: (_) => _startGame(),
    );
  }
}