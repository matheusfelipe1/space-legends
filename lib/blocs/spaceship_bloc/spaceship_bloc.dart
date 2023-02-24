import 'dart:async';

import 'package:space_legends/blocs/spaceship_bloc/spaceship_event.dart';
import 'package:space_legends/shared/models/spaceship.dart';

class SpaceShipBloC {
  final StreamController<SpaceShipModel> _inputSpaceShipController =
      StreamController<SpaceShipModel>();
  final StreamController<SpaceShipModel> _outputSpaceShipController =
      StreamController<SpaceShipModel>();

  Sink<SpaceShipModel> get inputSpaceship => _inputSpaceShipController.sink;
  Stream<SpaceShipModel> get stream => _outputSpaceShipController.stream;

  SpaceShipBloC() {
    _inputSpaceShipController.stream.listen(_mapEventsToState);
  }

  _mapEventsToState(SpaceShipModel space) {
    SpaceShipModel newSpace = SpaceShipModel();
    if (space is SpaceShipHitMe) {
      newSpace = space;
    } else if (space is SpaceShipKillMe) {
      newSpace = space;
    } else if (space is SpaceShipIShot) {
      newSpace = space;
    } else if (space is SpaceShipRaiseShields) {
      newSpace = space;
    } else if (space is SpaceShipRotate) {
      newSpace = space;
    }
    _outputSpaceShipController.add(newSpace);
  }
}
