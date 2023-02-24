class SpaceShipModel {
  String? nome;
  List<int>? vida;
  List<int>? escudo;
  List<int>? especial;
  double? vidaAtual;
  double? escudoAtual;
  double? especialAtual;

  SpaceShipModel(
      {this.nome,
      this.especial,
      this.escudo,
      this.vida,
      this.escudoAtual,
      this.especialAtual,
      this.vidaAtual});
}
