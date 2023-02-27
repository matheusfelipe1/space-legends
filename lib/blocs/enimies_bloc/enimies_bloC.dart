import 'dart:async';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_event.dart';
import 'package:space_legends/shared/models/enimeis.dart';
import 'package:space_legends/shared/models/orientation.dart';

class EnimiesBloC {
  EnimiesModel enimies = EnimiesModel();
  final StreamController<EnimiesEvent> _outputEnimies =
      StreamController<EnimiesEvent>.broadcast();
  final StreamController<EnimiesModel> _inputEnimies =
      StreamController<EnimiesModel>.broadcast();
  final StreamController<bool> _inputHit = StreamController<bool>.broadcast();
  final StreamController<bool> _inputDeath = StreamController<bool>.broadcast();

  final StreamController<OrientationModel> _orientationInputOutput =
      StreamController<OrientationModel>.broadcast();

  Stream<EnimiesEvent> get outputEnimies => _outputEnimies.stream;
  Stream<bool> get outputHit => _inputHit.stream;
  Stream<bool> get outputDeath => _inputDeath.stream;
  Sink<EnimiesModel> get inputEnimies => _inputEnimies.sink;
  Sink<bool> get inputHit => _inputHit.sink;
  Sink<bool> get inputDeath => _inputDeath.sink;
  Stream<OrientationModel> get outputOrientation =>
      _orientationInputOutput.stream;
  Sink<OrientationModel> get inputOrientation => _orientationInputOutput.sink;

  EnimiesBloC() {
    outputEnimies.listen(_mapEvents);
    outputHit.listen(_hitInEnimies);
    _startGame();
  }

  _mapEvents(EnimiesEvent event) {
    EnimiesModel enimies = EnimiesModel();
    if (event is LoadEnimies) {
      enimies = event.enimies;
    } else if (event is HitedEnimies) {
      enimies = event.enimies;
    } else if (event is DeathEnimies) {
      enimies = event.enimies;
    } else if (event is ShotEnimies) {
      enimies = event.enimies;
    }
    inputEnimies.add(enimies);
  }

  _startGame() {
    enimies.obj = Object(fileName: 'assets/cube/Low_poly_UFO.obj');
    enimies.obj!.transform
      ..setEntry(3, 2, 0.01)
      ..rotateY(0.7);
    enimies.vida = [];
    for (var i = 0; i < 40; i++) {
      enimies.vida!.add(i);
    }
  }

  _hitInEnimies(bool data) {
    // print(enimies.vida!.isEmpty);
    if (data) {
      if (enimies.vida!.isEmpty) {
        inputDeath.add(true);
        _restartEnimies();
      } else {
        enimies.vida!.removeLast();
      }
    }
  }

  _restartEnimies() {
    enimies.obj = Object(fileName: 'assets/cube/Low_poly_UFO.obj');
    enimies.obj!.transform
      ..setEntry(3, 2, 0.01)
      ..rotateY(0.7);
    enimies.vida = [];
    for (var i = 0; i < 40; i++) {
      enimies.vida!.add(i);
    }
    Future.delayed(const Duration(seconds: 7),() {
      inputDeath.add(false);
    });
  }
}
