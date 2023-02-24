import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_legends/shared/middleware/constants.dart';
import 'package:space_legends/views/gameover/gameover.dart';

import '../controller_plan.dart';

class LiveBar extends StatefulWidget {
  const LiveBar({Key? key}) : super(key: key);

  @override
  State<LiveBar> createState() => _LiveBarState();
}

class _LiveBarState extends State<LiveBar> {
  final _controllerPlan = ControllerPlan();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controllerPlan.startGame(context);
      _listening();
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _controllerPlan.hitMe(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedContainer(
            width: _controllerPlan.progressoVida,
            height: size.width * .02,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: _controllerPlan.vidaAtual <= 10
                    ? Colors.red
                    : _controllerPlan.vidaAtual > 10 &&
                            _controllerPlan.vidaAtual <= 20
                        ? Colors.yellow
                        : Colors.green,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(25)),
                border: Border.all(color: Colors.black, width: 2)),
          ),
          AnimatedContainer(
            width: _controllerPlan.progressoEscudo,
            height: size.width * .01,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(25)),
                border: Border.all(color: Colors.black, width: 2)),
          ),
        ],
      ),
    );
  }

  _listening() {
    _controllerPlan.notificando.listen((event) {
      if (mounted) setState(() {});
      if (_controllerPlan.vidaAtual == 0) {
        showCupertinoModalPopup(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              final size = MediaQuery.of(context).size;
              return AlertDialog(
                backgroundColor: Colors.transparent.withOpacity(0.65),
                content: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: const GameOverScreen()),
              );
            });
      }
    });
  }
}
