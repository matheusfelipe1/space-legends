
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

import '../controller_plan.dart';

class CubeWidget extends StatefulWidget {
  const CubeWidget({Key? key})
      : super(key: key);

  @override
  State<CubeWidget> createState() => _CubeWidgetState();
}

class _CubeWidgetState extends State<CubeWidget> {
  final _controllerPlan = ControllerPlan();
  @override
  void initState() {
    // TODO: implement initState
    _controllerPlan.listening();
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _controllerPlan.removeListener();
  }

  @override
  Widget build(BuildContext context) {
    return Cube(
      key: UniqueKey(),
      interactive: false,
      onSceneCreated: (scene) {
        scene.world.add(_controllerPlan.obj);
        scene.camera.zoom = 8;
      },
    );
  }
}
