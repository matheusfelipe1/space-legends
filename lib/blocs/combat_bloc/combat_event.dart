import 'package:space_legends/shared/models/combat.dart';

abstract class CombatEvent {}

class IShotCombat extends CombatEvent {
  CombatModel combat;
  IShotCombat(this.combat);
}

class HeShotedMeCombat extends CombatEvent {
  CombatModel combat;
  HeShotedMeCombat(this.combat);
}
