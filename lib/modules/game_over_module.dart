import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/views/gameover/gameover.dart';

class GameOverModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const GameOverScreen()),
  ];
}