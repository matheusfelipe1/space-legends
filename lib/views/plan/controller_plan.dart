import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:space_legends/shared/middleware/constants.dart';
import 'package:space_legends/shared/models/spaceship.dart';

class ControllerPlan {

  final SpaceShipModel space = SpaceShipModel();
  final Object obj =
      Object(fileName: 'assets/cube/Intergalactic_Spaceship-(Wavefront).obj');
  late StreamController<AccelerometerEvent> streamBody;
  final StreamController<bool> notificaProgressos = StreamController<bool>.broadcast();

  double progressoVida = 0.0;
  double progressoEscudo = 0.0;
  double qttDano = 0.0;
  double qttEscudo = 0.0;

  ControllerPlan() {
    obj.transform
      ..setEntry(3, 2, 0.01)
      ..rotateX(-0.7);
    listening();
  }

  listening() {
    streamBody = StreamController<AccelerometerEvent>.broadcast();
    accelerometerEvents.listen((event) {
      double eixoZ = (((event.y * pi) / 180) * .7);
      obj.transform
        ..setEntry(3, 2, 0.01)
        ..rotateZ(eixoZ)
        ..rotateX(0.0)
        ..rotateY(0.0);
      obj.rotation.setZero();
      if (!streamBody.isClosed) {
        streamBody.sink.add(event);
      }
      obj.rotation.setValues(0.0, 0.0, eixoZ);
    });
  }

  removeListener() {
    streamBody.close();
    accelerometerEvents.listen((event) {}).cancel();
  }

  startGame(BuildContext context) {
    space.vida = [];
    space.escudo = [];
    for (var i = 0; i < Constants.maxVida; i++) {
      space.vida!.add(i);
    }
    for (var i = 0; i < Constants.maxEscudo; i++) {
      space.escudo!.add(i);
    }
    final size = MediaQuery.of(context).size;
    qttDano = (size.width * .37) / space.vida!.length;
    qttEscudo = (size.width * .3) / space.escudo!.length;
    progressoVida = size.width * .37;
    progressoEscudo = size.width * .3;
  }

  hitMe() {
    double verifica = progressoVida;
    if ((verifica -= qttDano) <= 0.0) {
      progressoVida = 0.0;
      space.vida!.clear();
    } else {
      progressoVida -= qttDano;
    }
    if (space.vida!.isNotEmpty) {
      space.vida!.removeLast();
    } else {
      progressoVida = 0.0;
      gameOver();
    }
    notificaProgressos.sink.add(true);
  }

  avante() {
    double verifica = progressoEscudo;
    if ((verifica -= qttEscudo) <= 0.0) {
      progressoEscudo = 0.0;
      space.escudo!.clear();
    } else {
      progressoEscudo -= qttEscudo;
    }
    if (space.escudo!.isNotEmpty) {
      space.escudo!.removeLast();
    } else {
      progressoEscudo = 0.0;
    }
    notificaProgressos.sink.add(true);
  }

  gameOver() {
    print("gameover");
  }

  int get vidaAtual => space.vida == null ? 0 : space.vida!.length;
}
