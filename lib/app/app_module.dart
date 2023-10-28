import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/onboard/onboard_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const OnBoardPage());
    r.module('/home', module: HomeModule());
  }
}
