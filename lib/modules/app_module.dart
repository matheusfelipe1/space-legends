import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/modules/buffering_module.dart';
import 'package:space_legends/modules/game_module.dart';
import 'package:space_legends/modules/game_over_module.dart';
import 'package:space_legends/modules/login_module.dart';
import 'package:space_legends/views/splash/splash_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SplashScreen()),
    ModuleRoute('/game', module: GameModule()),
    ModuleRoute('/game-over', module: GameOverModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/loading', module: BufferingModule()),
  ];
}