import 'package:flutter/material.dart';
import 'package:space_legends/views/plan/widgets/stars.dart';

class GenerateSTARS extends StatefulWidget {
  const GenerateSTARS({Key? key}) : super(key: key);

  @override
  State<GenerateSTARS> createState() => _GenerateSTARSState();
}

class _GenerateSTARSState extends State<GenerateSTARS> {
  late List<Widget> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = List.generate(1000, (index) => const StarsComponent());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: data,
      alignment: Alignment.center,
    );
  }
}
