import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/configurations/app_configuration.dart';
import 'package:sentinela/app/modules/home/home_page.dart';
import 'package:sentinela/app/modules/home/pages/home_details_page.dart';
import 'package:sentinela/app/modules/home/pages/send_complaint_page.dart';
import 'package:sentinela/app/modules/home/repositories/home_repository.dart';
import 'package:sentinela/app/modules/home/repositories/i_home_repository.dart';
import 'package:sentinela/app/modules/home/store/home_store.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => Dio(BaseOptions(baseUrl: AppConfigure.apiUrl)));
    i.addLazySingleton<IHomeRepository>(HomeRepository.new);
    i.addLazySingleton<HomeStore>(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => HomePage(
              store: Modular.get<HomeStore>(),
            ));
    r.child('/complaint-send', child: (context) => const SendComplaintPage());
    r.child('/complaint-datails',
        child: (context) => HomeComplaintDetails(
              complaint: r.args.data,
            ));
  }
}
