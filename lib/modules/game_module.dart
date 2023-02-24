import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/views/plan/plan_screen.dart';

class GameModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const PlaScreen()),
  ];
}