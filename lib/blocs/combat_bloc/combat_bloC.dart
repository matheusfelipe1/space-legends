import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_legends/blocs/combat_bloc/combat_event.dart';
import 'package:space_legends/shared/models/combat.dart';

class CombatBloC {
  CombatModel combat = CombatModel();
  Completer<void> completer = Completer();
  bool cachedFrom = false;
  final StreamController<CombatEvent> _outputEvent =
      StreamController<CombatEvent>.broadcast();
  final StreamController<CombatModel> _eventCombat =
      StreamController<CombatModel>.broadcast();
  final StreamController<Offset> _inputMyOffset =
      StreamController<Offset>.broadcast();
  final StreamController<CombatModel> _shotsFromEnimies =
      StreamController<CombatModel>.broadcast();

  Sink<CombatModel> get inputShotsCombat => _shotsFromEnimies.sink;
  Sink<CombatModel> get inputCombat => _eventCombat.sink;
  Stream<CombatModel> get outputCombat => _eventCombat.stream;
  Stream<CombatModel> get outShotsputCombat => _shotsFromEnimies.stream;
  Sink<Offset> get inputOffset => _inputMyOffset.sink;
  Stream<CombatEvent> get output => _outputEvent.stream;
  Stream<Offset> get outputOffset => _inputMyOffset.stream;

  void get newCompleter => completer = Completer();
  Future<void> get awaitFunc async => await completer.future;
  bool get isFinish => completer.isCompleted;
  void get finish => completer.complete();

  CombatBloC() {
    _outputEvent.stream.listen(_mapEvent);
    _eventCombat.stream.listen(_mapEventCombat);
    _shotsFromEnimies.stream.listen(_mapShotsCombat);
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
   
  }
}
