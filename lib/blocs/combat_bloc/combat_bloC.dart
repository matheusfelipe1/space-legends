import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:space_legends/blocs/combat_bloc/combat_event.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_bloC.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';
import 'package:space_legends/shared/middleware/constants.dart';
import 'package:space_legends/shared/models/combat.dart';
import 'package:space_legends/shared/models/x1.dart';

class CombatBloC {
  CombatModel combat = CombatModel();
  Completer<void> completer = Completer();
  bool cachedFrom = false;
  bool canShoot = true;
  int scores = 0;
  int kills = 0;
  bool killed = false;
  late Timer periodc;
  final StreamController<CombatEvent> _outputEvent =
      StreamController<CombatEvent>.broadcast();
  final StreamController<CombatModel> _eventCombat =
      StreamController<CombatModel>.broadcast();
  final StreamController<Offset> _inputMyOffset =
      StreamController<Offset>.broadcast();
  final StreamController<CombatModel> _shotsFromEnimies =
      StreamController<CombatModel>.broadcast();
  final StreamController<Offset> _offsetAim =
      StreamController<Offset>.broadcast();
  final StreamController<X1Model> _1v1controller =
      StreamController<X1Model>.broadcast();
  final StreamController<bool> _iShotController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _iHited = StreamController<bool>.broadcast();

  final _spaceShipBloC = Modular.get<SpaceShipBloC>();
  final _enimiesBloC = Modular.get<EnimiesBloC>();

  Sink<CombatModel> get inputShotsCombat => _shotsFromEnimies.sink;
  Sink<CombatModel> get inputCombat => _eventCombat.sink;
  Stream<CombatModel> get outputCombat => _eventCombat.stream;
  Stream<CombatModel> get outShotsputCombat => _shotsFromEnimies.stream;
  Sink<Offset> get inputOffset => _inputMyOffset.sink;
  Stream<CombatEvent> get output => _outputEvent.stream;
  Stream<Offset> get outputOffset => _inputMyOffset.stream;
  Stream<bool> get outputIshot => _iShotController.stream;
  Sink<bool> get inputIshot => _iShotController.sink;
  Sink<Offset> get inputIshotOffset => _offsetAim.sink;
  Sink<X1Model> get inputIshotX1 => _1v1controller.sink;
  Stream<X1Model> get outputIshotX1 => _1v1controller.stream;
  Stream<Offset> get outputIshotOffset => _offsetAim.stream;
  Stream<bool> get outputIHit => _iHited.stream;
  Sink<bool> get inputIHit => _iHited.sink;

  void get newCompleter => completer = Completer();
  Future<void> get awaitFunc async => await completer.future;
  bool get isFinish => completer.isCompleted;
  void get finish => completer.complete();

  CombatBloC() {
    _outputEvent.stream.listen(_mapEvent);
    _eventCombat.stream.listen(_mapEventCombat);
    _shotsFromEnimies.stream.listen(_mapShotsCombat);
    _1v1controller.stream.listen(_startShotsFromMe);
    _startShotsByEnimies();
  }

  _mapEvent(CombatEvent event) {
    CombatModel combat = CombatModel();
    if (event is IShotCombat) {
      combat = event.combat;
    } else if (event is HeShotedMeCombat) {
      combat = event.combat;
    }
    inputCombat.add(combat);
  }

  _mapEventCombat(CombatModel combat) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!isFinish) finish;
    });
    await awaitFunc;
    if (combat.fromMe != cachedFrom) {
      cachedFrom = combat.fromMe!;
      inputShotsCombat.add(combat);
    }
  }

  _mapShotsCombat(CombatModel combat) {
    if (!combat.fromMe!) {
      _spaceShipBloC.hitedMe();
    }
  }

  _startShotsByEnimies() {
    periodc = Timer.periodic(const Duration(seconds: 20), (timer) {
      canShoot = !canShoot;
    });
  }

  _startShotsFromMe(X1Model x1Model) {
    if (!killed) {
      Offset start = x1Model.myCoordinates!;
      Offset end = x1Model.enimyCoordinates!;
      double radius =
          (Geolocator.distanceBetween(start.dx, start.dx, end.dx, end.dx) /
              100000);
      if (radius == 0.0) {
        inputIHit.add(true);
        scores += Constants.score;
        _enimiesBloC.inputHit.add(true);
      }
    }
  }

  enimyDown() {
    _enimiesBloC.inputHit.add(true);
    kills += 1;
    killed = true;
  }
}
