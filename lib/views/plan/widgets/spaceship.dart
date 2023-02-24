

import 'package:flutter/material.dart';
import 'package:space_legends/views/plan/controller_plan.dart';
import 'package:space_legends/views/plan/widgets/cube.dart';

class SpaceShip extends StatefulWidget {
  const SpaceShip({Key? key}) : super(key: key);

  @override
  State<SpaceShip> createState() => _SpaceShipState();
}

class _SpaceShipState extends State<SpaceShip> {
  final _controllerPlan = ControllerPlan();
  double inclinacao = 0.0;
  double deslocamento = 0.0;
  double eixoY = 0.0;
  double eixoX = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPlan.listening();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _listening();
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _controllerPlan.removeListener();
  }

  _listening() {
    _controllerPlan.datas.listen((event) {
      inclinacao = _controllerPlan.obj.transform.getRotation()[1];
      eixoX = inclinacao >= -0.4 && inclinacao <= 0.4
          ? 1.0
          : inclinacao >= 0.4
              ? 200.0
              : -200.0;
      eixoY = event.x >= 5 ? 60 : -60;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: 600,
        height: 250,
        child: SizedBox(
            height: 450,
            width: 450,
            child: AnimatedContainer(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..translate(eixoX, eixoY),
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              child: const CubeWidget(),
            )),
      ),
    );
  }
}
