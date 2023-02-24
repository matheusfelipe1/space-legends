import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScene extends StatefulWidget {
  List<CameraDescription> cameras;
  CameraScene({ Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraScene> createState() => _CameraSceneState();
}

class _CameraSceneState extends State<CameraScene> {
  late CameraController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CameraController(widget.cameras.first, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: CameraPreview(controller),
    );
  }
}