import 'package:space_legends/shared/models/enimeis.dart';

abstract class EnimiesEvent {}

class LoadEnimies extends EnimiesEvent {
  EnimiesModel enimies;
  LoadEnimies({
    required this.enimies
  });
}

class HitedEnimies extends EnimiesEvent {
  EnimiesModel enimies;
  HitedEnimies({
    required this.enimies
  });
}

class DeathEnimies extends EnimiesEvent {
  EnimiesModel enimies;
  DeathEnimies({
    required this.enimies
  });
}

class ShotEnimies extends EnimiesEvent {
  EnimiesModel enimies;
  ShotEnimies({
    required this.enimies
  });
}

