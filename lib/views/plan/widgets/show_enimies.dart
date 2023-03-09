import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_bloC.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';

import 'enimies.dart';

class ShowEnimies extends StatefulWidget {
  const ShowEnimies({Key? key}) : super(key: key);

  @override
  State<ShowEnimies> createState() => _ShowEnimiesState();
}

class _ShowEnimiesState extends State<ShowEnimies> {
  final _bloCEnimy = Modular.get<EnimiesBloC>();
  final _bloCCombat = Modular.get<CombatBloC>();
  final _spaceShip = Modular.get<SpaceShipBloC>();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: StreamBuilder<bool>(
      key: UniqueKey(),
          stream: _bloCEnimy.outputDeath,
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data == true) {
              _bloCCombat.enimyDown();
              _spaceShip.downEnimy();
            } else if (snapshot.data != null && snapshot.data == false) {
              _bloCCombat.killed = false;
            }
            return snapshot.data == null
                ? const SizedBox()
                : snapshot.data == true
                    ? const SizedBox()
                    : Container(
                        key: UniqueKey(),
                        child: const Enimies(),
                      );
          }),
    );
  }
}
