import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';

class StarsComponent extends StatefulWidget {
  double x, y;
  int index;
  StarsComponent(
      {Key? key, required this.x, required this.y, required this.index})
      : super(key: key);

  @override
  State<StarsComponent> createState() => _StarsComponentState();
}

class _StarsComponentState extends State<StarsComponent> with TickerProviderStateMixin {
  final _key = GlobalKey();
  late AnimationController controller;
  late Animation<Offset> animate;
  final _spaceShipBloC = Modular.get<SpaceShipBloC>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Offset>>(
        stream: null,
        builder: (context, snapshot) {
          List<Offset> data = snapshot.data ?? [];
          if (data.isNotEmpty){
            _initiAnimation(Offset(widget.x, widget.y), data[widget.index]);
          }
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 3000),
            opacity: data.isNotEmpty ? 0.0 : 1.0,
            child: AnimatedContainer(
                duration: const Duration(seconds: 60),
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.01)
                  ..translate(data.isEmpty ? widget.x : animate.value.dx,
                      data.isEmpty ? widget.y : animate.value.dy),
                key: _key,
                child: CircleAvatar(
                  radius: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )),
          );
        });
  }

  _initiAnimation(Offset initial, Offset end) {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))..repeat(reverse: true);
    animate = Tween<Offset>(end: end, begin: initial).animate(controller);
  }
}
