import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/blocs/spaceship_bloc/spaceship_bloc.dart';
import 'package:space_legends/views/plan/provider_controller.dart';
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                'assets/images/gif.gif',
                fit: BoxFit.cover,
              )),
          const SpaceShip(),
          Positioned(
              top: size.width * .04,
              right: size.width * .04,
              child: const LiveBar())
        ],
      ),
      // ignore: deprecated_member_use
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(
          FontAwesomeIcons.boltLightning,
        ),
        backgroundColor: const Color.fromARGB(255, 231, 161, 39),
      ),
    );
  }
}
