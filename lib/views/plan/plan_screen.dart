import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';
import 'package:space_legends/views/plan/provider_controller.dart';
import 'package:space_legends/views/plan/widgets/buffering_game.dart';
import 'package:space_legends/views/plan/widgets/live_bar.dart';
import 'package:space_legends/views/plan/widgets/spaceship.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaScreen extends StatefulWidget {
  const PlaScreen({Key? key}) : super(key: key);

  @override
  State<PlaScreen> createState() => _PlaScreenState();
}

class _PlaScreenState extends State<PlaScreen> {
  final _spaceShipBloC = Modular.get<SpaceShipBloC>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final read = Provider.of<ProviderController>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          // SizedBox(
          //     height: size.height,
          //     width: size.width,
          //     child: Image.asset(
          //       'assets/images/gif.gif',
          //       fit: BoxFit.cover,
          //     )),
          SpaceShip(
            showShield: _spaceShipBloC.saudeEscudo > 0 &&
                _spaceShipBloC.space.showShield! == true,
          ),
          Positioned(
              top: size.width * .04,
              right: size.width * .04,
              child: const LiveBar()),
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
          if (!read.objectCreated) const BufferingGame()
        ],
      ),
      // ignore: deprecated_member_use
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: !read.objectCreated
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: '0',
                  onPressed: () {
                    _spaceShipBloC.raisedShield();
                    setState(() {});
                  },
                  child: Icon(_spaceShipBloC.space.showShield!
                      ? Icons.cancel_outlined
                      : FontAwesomeIcons.shield),
                  backgroundColor: _spaceShipBloC.space.showShield!
                      ? Colors.red
                      : Colors.blue,
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTapDown: (details) => _spaceShipBloC.startShot(),
                  onTapUp: (details) => _spaceShipBloC.stopShot(),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 217, 142, 4),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Icon(FontAwesomeIcons.boltLightning,
                            color: Colors.white)),
                  ),
                )
              ],
            ),
    );
  }
}
