import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_bloC.dart';
import 'package:space_legends/shared/models/combat.dart';
import 'package:space_legends/shared/models/orientation.dart';

import '../../../shared/models/x1.dart';
import 'enime_obj.dart';
import 'enimies_shot.dart';

class Enimies extends StatefulWidget {
  const Enimies({Key? key}) : super(key: key);

  @override
  State<Enimies> createState() => _EnimiesState();
}

class _EnimiesState extends State<Enimies> {
  final _bloCEnimies = Modular.get<EnimiesBloC>();
  final _bloCCombat = Modular.get<CombatBloC>();
  late Stream periodic;
  late StreamSubscription _subs;
  final List<double> possiblePositions = <double>[1.0, -200.0, 200.0];
  double positionCached = 1.0;
  bool firstBuild = true;
  Offset? enimyOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _listeningShots();
      _randomPosition();
      periodic =
          Stream.periodic(const Duration(seconds: 10), (computationCount) {
        return null;
      }).takeWhile((element) => true);
      _listeningPositions();
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _subs.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: UniqueKey(),
      child: Column(
        children: [
          SizedBox(
            width: 600,
            height: 200,
            child: SizedBox(
              width: 200,
              height: 200,
              child: StreamBuilder<OrientationModel>(
                  key: UniqueKey(),
                  stream: _bloCEnimies.outputOrientation,
                  builder: (context, snapshot) {
                    double eixoX = snapshot.data == null
                        ? 1.0
                        : snapshot.data!.horizontal!;
                    enimyOffset = Offset(eixoX, 0.0);
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..translate(eixoX, 0.0),
                      child: const EnimeObj(),
                    );
                  }),
            ),
          ),
          StreamBuilder<CombatModel>(
              key: UniqueKey(),
              stream: _bloCCombat.outShotsputCombat,
              builder: (context, snapshot) {
                double x = snapshot.data == null
                    ? 1.0
                    : snapshot.data!.myCoordinates!.dx;
                double y = snapshot.data == null
                    ? 1.0
                    : snapshot.data!.myCoordinates!.dy;
                bool fromMe =
                    snapshot.data == null ? false : snapshot.data!.fromMe!;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 50),
                  opacity: fromMe && _bloCCombat.canShoot ? 1.0 : 0.0,
                  child: AnimatedContainer(
                      height: 90,
                      width: 90,
                      duration: const Duration(milliseconds: 100),
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..translate(x, fromMe ? y / 100 : -150.0),
                      curve: Curves.easeInOut,
                      child: const EnimiesShot()),
                );
              })
        ],
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

  _listeningShots() {
    _bloCCombat.outputIshotOffset.listen((event) {
      if (enimyOffset != null) {
        X1Model x1 =
            X1Model(myCoordinates: event, enimyCoordinates: enimyOffset);
        _bloCCombat.inputIshotX1.add(x1);
      }
    });
  }

  _listeningPositions() {
    _subs = periodic.listen((event) {
      if (_bloCCombat.killed) {
        _subs.cancel();
      } else {
        _randomPosition();
        firstBuild = false;
      }
    });
  }
}
