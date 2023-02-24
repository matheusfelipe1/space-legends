import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:space_legends/shared/middleware/constants.dart';
import 'package:space_legends/shared/models/show_data_spaceship.dart';
import 'package:space_legends/shared/models/spaceship.dart';

class ControllerPlan {

  final SpaceShipModel space = SpaceShipModel();
  final ShowDataSpaceShip progressDataSpaceship = ShowDataSpaceShip();
  final Object obj =
      Object(fileName: 'assets/cube/Intergalactic_Spaceship-(Wavefront).obj');
  late StreamController<AccelerometerEvent> streamBody;
  late Stream<AccelerometerEvent> datas;
  final StreamController<bool> notificaProgressos = StreamController<bool>.broadcast();
  late Stream<bool> notificando;

  double progressoVida = 0.0;
  double progressoPropulsao = 0.0;
  double qttDano = 0.0;
  double qttPropulsao = 0.0;

  ControllerPlan() {
    obj.transform
      ..setEntry(3, 2, 0.01)
      ..rotateX(-0.7);
    listening();
  }

  listening() {
    streamBody = StreamController<AccelerometerEvent>.broadcast();
    if (!streamBody.isClosed) {
      datas = streamBody.stream;
    }
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
    datas.listen((event) {}).cancel();
  }

  startGame(BuildContext context) {
    notificando = notificaProgressos.stream;
    space.vida = [];
    space.propulsao = [];
    for (var i = 0; i < Constants.maxLife; i++) {
      space.vida!.add(i);
    }
    for (var i = 0; i < Constants.maxPropulsao; i++) {
      space.propulsao!.add(i);
    }
    final size = MediaQuery.of(context).size;
    qttDano = (size.width * .37) / space.vida!.length;
    qttPropulsao = (size.width * .3) / space.propulsao!.length;
    progressoVida = size.width * .37;
    progressoPropulsao = size.width * .3;
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
    double verifica = progressoPropulsao;
    if ((verifica -= qttPropulsao) <= 0.0) {
      progressoPropulsao = 0.0;
      space.propulsao!.clear();
    } else {
      progressoPropulsao -= qttPropulsao;
    }
    if (space.propulsao!.isNotEmpty) {
      space.propulsao!.removeLast();
    } else {
      progressoPropulsao = 0.0;
    }
    notificaProgressos.sink.add(true);
  }

  gameOver() {
    print("gameover");
  }

  int get vidaAtual => space.vida == null ? 0 : space.vida!.length;
}
