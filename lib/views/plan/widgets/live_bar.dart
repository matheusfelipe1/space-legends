import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/shared/models/spaceship.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';

class LiveBar extends StatefulWidget {
  const LiveBar({Key? key}) : super(key: key);

  @override
  State<LiveBar> createState() => _LiveBarState();
}

class _LiveBarState extends State<LiveBar> {
  final _blocSpaceShip = Modular.get<SpaceShipBloC>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<SpaceShipModel>(
        stream: _blocSpaceShip.stream,
        builder: (context, snapshot) {
          double escudoAtual =
              snapshot.data == null ? 1.0 : snapshot.data!.escudoAtual ?? 1.0;
          double vidaAtual =
              snapshot.data == null ? 1.0 : snapshot.data!.vidaAtual ?? 1.0;
          if (vidaAtual <= 0.0) {
            Modular.to.pushReplacementNamed('/game-over/');
          }
          int vida = snapshot.data == null ? 1 : snapshot.data!.vida!.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedContainer(
                width: vidaAtual,
                height: size.width * .02,
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: vida <= 10
                        ? Colors.red
                        : vida > 10 && vida <= 20
                            ? Colors.yellow
                            : Colors.green,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25)),
                    border: Border.all(color: Colors.black, width: 2)),
              ),
              AnimatedContainer(
                width: escudoAtual,
                height: size.width * .01,
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25)),
                    border: Border.all(color: Colors.black, width: 2)),
              ),
            ],
          );
        });
  }
}
