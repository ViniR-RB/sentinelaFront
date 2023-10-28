import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/configurations/app_configuration.dart';
import 'package:sentinela/app/core/services/shared_user_service.dart';
import 'package:sentinela/app/modules/error/error_page.dart';
import 'package:sentinela/app/modules/onboard/onboard_page.dart';
import 'package:sentinela/app/modules/splash/repository/i_splash_repository.dart';
import 'package:sentinela/app/modules/splash/repository/splash_repository.dart';
import 'package:sentinela/app/modules/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/home_module.dart';
import 'modules/splash/controller/splash_controller.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => Dio(BaseOptions(baseUrl: AppConfigure.apiUrl)));
    i.addSingleton<ISplashRepository>(SplashRepositoryImpl.new);
    i.addSingleton(SplashController.new);
    i.addLazySingleton(SharedUserService.new);
    i.addSingleton<Future<SharedPreferences>>(
      () => SharedPreferences.getInstance(),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => SplashPage(
              controller: Modular.get<SplashController>(),
            ));
    r.child('/onboard', child: (context) => const OnBoardPage());
    r.child('/error',
        child: (context) => ErrorPage(
              exception: r.args.data,
              message: r.args.data.message,
            ));
    r.module('/home', module: HomeModule());
  }
}
