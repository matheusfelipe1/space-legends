
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';

import '../provider_controller.dart';

class CubeWidget extends StatefulWidget {
  const CubeWidget({Key? key})
      : super(key: key);

  @override
  State<CubeWidget> createState() => _CubeWidgetState();
}

class _CubeWidgetState extends State<CubeWidget> {
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
    final read = Provider.of<ProviderController>(context, listen: false);
    return Cube(
      key: UniqueKey(),
      interactive: false,
      onSceneCreated: (scene) {
        scene.world.add(_blocSpaceShip.space.obj!);
        scene.camera.zoom = 8;
      },
    );
  }
}
