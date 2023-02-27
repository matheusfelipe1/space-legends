import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:space_legends/shared/models/spaceship.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';
import '../provider_controller.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final read = Provider.of<ProviderController>(context, listen: false);
    return StreamBuilder<SpaceShipModel>(
      key: UniqueKey(),
        stream: _blocSpaceShip.stream,
        builder: (context, snapshot) {
          double escudoAtual =
              snapshot.data == null ? 1.0 : snapshot.data!.escudoAtual ?? 1.0;
          double vidaAtual =
              snapshot.data == null ? 1.0 : snapshot.data!.vidaAtual ?? 1.0;
          if (vidaAtual <= 0.0) {
            Modular.to.pushReplacementNamed('/game-over/');
          }
          if (_blocSpaceShip.saudeEscudo == 0) {
            read.updateState();
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
              const Text('Matheus', style: TextStyle(color: Colors.white,fontSize: 25.2, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)
            ],
          );
        });
  }
}
