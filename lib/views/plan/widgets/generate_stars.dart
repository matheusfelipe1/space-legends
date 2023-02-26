import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:space_legends/shared/middleware/constants.dart';
import 'package:space_legends/views/plan/widgets/stars.dart';

import '../../../blocs/spaceship_bloc/spaceship_bloc.dart';
import '../provider_controller.dart';

class GenerateSTARS extends StatefulWidget {
  List<Offset> offsets;
  GenerateSTARS({Key? key, required this.offsets}) : super(key: key);

  @override
  State<GenerateSTARS> createState() => _GenerateSTARSState();
}

class _GenerateSTARSState extends State<GenerateSTARS> {
  final _spaceShipBloC = Modular.get<SpaceShipBloC>();
  List<Offset> offsets = [];
  List<Offset> offsetsAnimations = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generatePositionStars();
  }

  @override
  Widget build(BuildContext context) {
    return widget.offsets.isNotEmpty &&
            (offsets.isNotEmpty || offsetsAnimations.isNotEmpty)
        ? Stack(
            key: UniqueKey(),
            children: List.generate(
                200,
                (index) => StarsComponent(
                      x: offsets[index].dx,
                      y: offsets[index].dy,
                      index: index,
                    )),
            alignment: Alignment.center,
          )
        : const SizedBox();
  }

  double get next => Random().nextInt(700).toDouble();

  generatePositionStars() {
    List<Offset> offsets = [];
    for (var i = 0; i < 200; i++) {
      if (i == 0) {
        Offset off = Offset.zero;
        offsets.add(off);
      } else {
        Offset off = Offset(next, next);
        bool valid = false;
        for (var item in offsets) {
          valid = calculateCoordinates(item.dx, item.dy, off.dx, off.dy);
          while (!valid) {
            off = Offset(next, next);
            valid = calculateCoordinates(item.dx, item.dy, off.dx, off.dy);
          }
        }
        if (valid) {
          offsets.add(off);
        }
      }
    }
    this.offsets = offsets;
    animationOffsets();
  }

  calculateCoordinates(double startX, double startY, double endX, double endY) {
    final teste = Geolocator.distanceBetween(startX, startY, endX, endY);
    if (teste <= Constants.neighborhood) {
      return false;
    }
    return true;
  }

  animationOffsets() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.offsets.isNotEmpty) {
        List<Offset> offsetsAnimations = [];
        for (var item in offsets) {
          List<double> returned = [];
          List<double> returnedCached = [];
          for (var data in widget.offsets) {
            final value =
                Geolocator.distanceBetween(item.dx, item.dy, data.dx, data.dy);
            returned.add(value);
            returnedCached.add(value);
          }
          returned.sort((a, b) => a < b ? 1 : -1);
          final element = returned.first;
          final int index = returnedCached.indexOf(element);
          offsetsAnimations.add(widget.offsets[index]);
        }
        this.offsetsAnimations = offsetsAnimations;
      }
    });
  }
}
