import 'package:space_legends/shared/models/spaceship.dart';

abstract class SpaceShipEvent {}

class SpaceShipHitMe extends SpaceShipEvent {
  SpaceShipModel spaceShipModel;
  SpaceShipHitMe({required this.spaceShipModel});
}

class SpaceShipKillMe extends SpaceShipEvent {
  SpaceShipModel spaceShipModel;
  SpaceShipKillMe({required this.spaceShipModel});
}

class SpaceShipRaiseShields extends SpaceShipEvent {
  SpaceShipModel spaceShipModel;
  SpaceShipRaiseShields({required this.spaceShipModel});
}

class SpaceShipIShot extends SpaceShipEvent {
  SpaceShipModel spaceShipModel;
  SpaceShipIShot({required this.spaceShipModel});
}

class SpaceShipRotate extends SpaceShipEvent {
  SpaceShipModel spaceShipModel;
  SpaceShipRotate({required this.spaceShipModel});
}
