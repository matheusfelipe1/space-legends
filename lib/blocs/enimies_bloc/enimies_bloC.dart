import 'dart:async';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_event.dart';
import 'package:space_legends/shared/models/enimeis.dart';
import 'package:space_legends/shared/models/orientation.dart';

class EnimiesBloC {
  EnimiesModel enimies = EnimiesModel();
  final StreamController<EnimiesEvent> _outputEnimies = StreamController<EnimiesEvent>.broadcast();
  final StreamController<EnimiesModel> _inputEnimies = StreamController<EnimiesModel>.broadcast();

  final StreamController<OrientationModel> _orientationInputOutput = StreamController<OrientationModel>.broadcast();

  Stream<EnimiesEvent> get outputEnimies => _outputEnimies.stream;
  Sink<EnimiesModel> get inputEnimies => _inputEnimies.sink;
  Stream<OrientationModel> get outputOrientation => _orientationInputOutput.stream;
  Sink<OrientationModel> get inputOrientation => _orientationInputOutput.sink;

  EnimiesBloC() {
    outputEnimies.listen(_mapEvents);
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
    enimies.obj!.transform..setEntry(3, 2, 0.01)..rotateY(0.7);
    enimies.vida = [];
    for (var i = 0; i < 15; i++) {
      enimies.vida!.add(i);
    }
  }
}