import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/combat_bloc/combat_bloC.dart';
import 'package:space_legends/blocs/enimies_bloc/enimies_bloC.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';
import 'package:space_legends/views/plan/widgets/live_bar.dart';
import 'package:space_legends/views/plan/widgets/scores.dart';
import 'package:space_legends/views/plan/widgets/show_enimies.dart';
import 'package:space_legends/views/plan/widgets/spaceship.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/models/spaceship.dart';

class PlaScreen extends StatefulWidget {
  const PlaScreen({Key? key}) : super(key: key);

  @override
  State<PlaScreen> createState() => _PlaScreenState();
}

class _PlaScreenState extends State<PlaScreen> {
  final _spaceShipBloC = Modular.get<SpaceShipBloC>();
  final _enimyBloC = Modular.get<EnimiesBloC>();
  final _blocCombat = Modular.get<CombatBloC>();
  List<Offset> offsets = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocCombat.newCompleter;
    _blocCombat.finish;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Future.delayed(const Duration(seconds: 7), () {
      _enimyBloC.inputDeath.add(false);
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        key: UniqueKey(),
        children: [
          const SpaceShip(),
          Positioned(
              top: size.width * .04,
              right: size.width * .04,
              child: LiveBar(
                key: UniqueKey(),
              )),
          const ShowEnimies(),
          const Positioned(
            bottom: 0,
            left: 0,
            child:  Scores()),
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                height: size.width * .7,
                width: size.width,
                child: GestureDetector(
                    onPanUpdate: (details) =>
                        _spaceShipBloC.moveUpOrDown(details.delta.dy)),
              )),
          // if (!read.objectCreated) const BufferingGame(),
        ],
      ),
      // ignore: deprecated_member_use
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<SpaceShipModel>(
            key: UniqueKey(),
              stream: _spaceShipBloC.stream,
              builder: (context, snapshot) {
                return FloatingActionButton(
                  heroTag: '0',
                  onPressed: () {
                    _spaceShipBloC.raisedShield();
                  },
                  child: Icon(
                      snapshot.data != null && snapshot.data!.showShield!
                          ? Icons.cancel_outlined
                          : FontAwesomeIcons.shield),
                  backgroundColor:
                      snapshot.data != null && snapshot.data!.showShield!
                          ? Colors.red
                          : Colors.blue,
                );
              }),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<SpaceShipModel>(
            key: UniqueKey(),
              stream: _spaceShipBloC.stream,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTapDown: snapshot.data != null && snapshot.data!.showShield!
                      ? null
                      : (details) => _spaceShipBloC.startShot(),
                  onTapUp: snapshot.data != null && snapshot.data!.showShield!
                      ? null
                      : (details) => _spaceShipBloC.stopShot(),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        color:
                            snapshot.data != null && snapshot.data!.showShield!
                                ? const Color.fromARGB(255, 191, 187, 179)
                                : const Color.fromARGB(255, 217, 142, 4),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Icon(FontAwesomeIcons.boltLightning,
                            color: Colors.white)),
                  ),
                );
              })
        ],
      ),
    );
  }
}
