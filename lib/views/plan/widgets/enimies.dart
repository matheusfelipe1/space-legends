import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_bloC.dart';
import 'package:space_legends/shared/models/orientation.dart';

import 'enime_obj.dart';

class Enimies extends StatefulWidget {
  const Enimies({Key? key}) : super(key: key);

  @override
  State<Enimies> createState() => _EnimiesState();
}

class _EnimiesState extends State<Enimies> {
  final _bloCEnimies = Modular.get<EnimiesBloC>();
  late Timer periodic;
  final List<double> possiblePositions = <double>[1.0, -200.0, 200.0];
  double positionCached = 1.0;
  bool firstBuild = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _randomPosition();
    periodic = Timer.periodic(const Duration(seconds: 10), (timer) {
      _randomPosition();
      firstBuild = false;
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    periodic.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    periodic.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: 600,
        height: 200,
        child: SizedBox(
          width: 200,
          height: 200,
          child: StreamBuilder<OrientationModel>(
              stream: _bloCEnimies.outputOrientation,
              builder: (context, snapshot) {
                double eixoX =
                    snapshot.data == null ? 1.0 : snapshot.data!.horizontal!;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.01)
                    ..translate(eixoX,  -110.0),
                  child: const EnimeObj(),
                );
              }),
        ),
      ),
    );
  }

  _randomPosition() {
    int index = Random().nextInt(3);
    if (index < 3) {
      double valueEixoX = possiblePositions[index];
      bool canProgress = _verifyAlreadyVisited(valueEixoX, positionCached);
      while (canProgress) {
        debugPrint('aqui no cached');
        index = Random().nextInt(3);
        while (index == 3) {
          index = Random().nextInt(3);
        }
        valueEixoX = possiblePositions[index];
        canProgress = _verifyAlreadyVisited(valueEixoX, positionCached);
      }
      positionCached = valueEixoX;
      OrientationModel orientationModel =
          OrientationModel(horizontal: valueEixoX, vertical: 1.0);
      _bloCEnimies.inputOrientation.add(orientationModel);
    }
  }

  bool _verifyAlreadyVisited(double data1, double data2) {
    if (data1 == data2) {
      return true;
    }
    return false;
  }
}
