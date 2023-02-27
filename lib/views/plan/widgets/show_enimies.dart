import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_bloC.dart';

import 'enimies.dart';

class ShowEnimies extends StatefulWidget {
  const ShowEnimies({Key? key}) : super(key: key);

  @override
  State<ShowEnimies> createState() => _ShowEnimiesState();
}

class _ShowEnimiesState extends State<ShowEnimies> {
  final _bloCEnimy = Modular.get<EnimiesBloC>();
  final _bloCCombat = Modular.get<CombatBloC>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _bloCEnimy.outputDeath,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data == true) {
            _bloCCombat.enimyDown();
          }
          return snapshot.data == null
              ? const SizedBox()
              : snapshot.data == true
                  ? const SizedBox()
                  : Container(
                      key: UniqueKey(),
                      child: const Enimies(),
                    );
        });
  }
}
