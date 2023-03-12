import 'package:flutter_modular/flutter_modular.dart';
import 'package:space_legends/views/login/login_screen.dart';

class LoginModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const LoginScreen())
  ];
}