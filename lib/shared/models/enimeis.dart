import 'package:flutter_cube/flutter_cube.dart';

class EnimiesModel {
  List<int>? vida;
  double? qttDano;
  double? qttEscudo;
  Object? obj;
  bool? iShot;

  EnimiesModel({
    this.iShot,
    this.obj,
    this.qttDano,
    this.qttEscudo,
    this.vida
  });
}