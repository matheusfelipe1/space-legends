import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/modules/game_module.dart';
import 'package:space_legends/views/splash/splash_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SplashScreen()),
    ModuleRoute('/default', module: GameModule())
  ];
}