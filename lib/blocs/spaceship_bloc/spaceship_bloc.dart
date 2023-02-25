import 'dart:async';
import 'dart:math';

import 'package:flutter_cube/flutter_cube.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_event.dart';
import 'package:space_legends/shared/models/orientation.dart';
import 'package:space_legends/shared/models/spaceship.dart';

import '../../shared/middleware/constants.dart';

class SpaceShipBloC {
  SpaceShipModel space = SpaceShipModel();
  final StreamController<SpaceShipEvent> _inputSpaceShipController =
      StreamController<SpaceShipEvent>();
  final StreamController<SpaceShipModel> _outputSpaceShipController =
      StreamController<SpaceShipModel>();
  final StreamController<OrientationModel> _streamOrientation = StreamController<OrientationModel>();

  Sink<SpaceShipEvent> get inputSpaceship => _inputSpaceShipController.sink;
  Stream<SpaceShipModel> get stream => _outputSpaceShipController.stream;
  Stream<OrientationModel> get streamOrientation => _streamOrientation.stream;

  SpaceShipBloC() {
    _inputSpaceShipController.stream.listen(_mapEventsToState);
    _initialize();
    listening();
  }

  _mapEventsToState(SpaceShipEvent event) {
    SpaceShipModel newSpace = SpaceShipModel();
    if (event is SpaceShipHitMe) {
      newSpace = event.spaceShipModel;
    } else if (event is SpaceShipKillMe) {
      newSpace = event.spaceShipModel;
    } else if (event is SpaceShipIShot) {
      newSpace = event.spaceShipModel;
    } else if (event is SpaceShipRaiseShields) {
      newSpace = event.spaceShipModel;
    } else if (event is SpaceShipRotate) {
      newSpace = event.spaceShipModel;
    } else if (event is SpaceShipLoad) {
      newSpace = event.spaceShipModel;
    }
    _outputSpaceShipController.add(newSpace);
  }

  _initialize() {
    SpaceShipModel space = SpaceShipModel();
    space.obj = Object(fileName: 'assets/cube/Intergalactic_Spaceship-(Wavefront).obj');
    space.vida = [];
    space.escudo = [];
    for (var i = 0; i < Constants.maxVida; i++) {
      space.vida!.add(i);
    }
    for (var i = 0; i < Constants.maxEscudo; i++) {
      space.escudo!.add(i);
    }
    space.qttDano = 250 / space.vida!.length;
    space.qttEscudo = 230 / space.escudo!.length;
    space.vidaAtual = 250;
    space.escudoAtual = 230;
    space.obj!.transform..setEntry(3, 2, 0.01)
      ..rotateX(-0.7);
    this.space = space;
    SpaceShipLoad valueToAdd = SpaceShipLoad(spaceShipModel: space);
    _inputSpaceShipController.sink.add(valueToAdd);
  }

  listening() {
    accelerometerEvents.listen((event) {
      double eixoZ = (((event.y * pi) / 180) * .7);
      space.obj!.transform
        ..setEntry(3, 2, 0.01)
        ..rotateZ(eixoZ)
        ..rotateX(0.0)
        ..rotateY(0.0);
      space.obj!.rotation.setZero();
      space.obj!.rotation.setValues(0.0, 0.0, eixoZ);
      OrientationModel orientationModel = OrientationModel();
      orientationModel.horizontal = space.obj!.transform.getRotation()[1];
      orientationModel.vertical = event.x;
      _streamOrientation.sink.add(orientationModel);
    });
  }

  hitedMe() {
    double verifica = space.vidaAtual!;
    if ((verifica -= space.qttDano!) <= 0.0) {
      space.vidaAtual = 0.0;
      space.vida!.clear();
    } else {
      double vida = space.vidaAtual!;
      double dano = space.qttDano!;
      space.vidaAtual = vida - dano;
    }
    if (space.vida!.isNotEmpty) {
      space.vida!.removeLast();
    } else {
      space.vidaAtual = 0.0;
    }
    _inputSpaceShipController.sink.add(SpaceShipHitMe(spaceShipModel: space));
  }

  raisedShield() {
    double verifica = space.escudoAtual!;
    if ((verifica -= space.qttEscudo!) <= 0.0) {
      space.escudoAtual = 0.0;
      space.escudo!.clear();
    } else {
      double escudo = space.escudoAtual!;
      double carga = space.qttEscudo!;
      space.escudoAtual = escudo - carga;
    }
    if (space.escudo!.isNotEmpty) {
      space.escudo!.removeLast();
    } else {
      space.escudoAtual = 0.0;
    }
    _inputSpaceShipController.sink.add(SpaceShipRaiseShields(spaceShipModel: space));
  }
}
