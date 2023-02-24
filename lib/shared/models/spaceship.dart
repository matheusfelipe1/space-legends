import 'package:flutter_cube/flutter_cube.dart';

class SpaceShipModel {
  String? nome;
  List<int>? vida;
  List<int>? escudo;
  List<int>? especial;
  double? vidaAtual;
  double? escudoAtual;
  double? especialAtual;
  double? qttDano;
  Object? obj;

  SpaceShipModel(
      {this.nome,
      this.especial,
      this.escudo,
      this.vida,
      this.escudoAtual,
      this.especialAtual,
      this.qttDano,
      this.obj,
      this.vidaAtual});
}
