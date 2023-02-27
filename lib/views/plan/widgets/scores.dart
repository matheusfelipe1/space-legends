import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';

class Scores extends StatefulWidget {
  const Scores({Key? key}) : super(key: key);

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  final _blocCombat = Modular.get<CombatBloC>();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: StreamBuilder<bool>(
      key: UniqueKey(),
        stream: _blocCombat.outputIHit,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kills: ' + _blocCombat.kills.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.2,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
             const  Divider(color: Colors.white, thickness: 30, height: 10),
              Text(
                'Scores: ' + _blocCombat.scores.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.2,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              )
            ],
          );
        }
      ),
    );
  }
}
