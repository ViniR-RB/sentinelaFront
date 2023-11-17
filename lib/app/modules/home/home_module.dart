import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/app_module.dart';
import 'package:sentinela/app/modules/home/home_page.dart';
import 'package:sentinela/app/modules/home/pages/home_details_page.dart';
import 'package:sentinela/app/modules/home/pages/send_complaint_page.dart';
import 'package:sentinela/app/modules/home/repositories/home_repository.dart';
import 'package:sentinela/app/modules/home/repositories/i_home_repository.dart';
import 'package:sentinela/app/modules/home/repositories/i_send_complaint_repository.dart';
import 'package:sentinela/app/modules/home/repositories/send_complaint_repository.dart';
import 'package:sentinela/app/modules/home/store/home_store.dart';
import 'package:sentinela/app/modules/home/store/send_complaint_store.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton<IHomeRepository>(HomeRepository.new);
    i.addLazySingleton<HomeStore>(HomeStore.new);

    i.addLazySingleton<ISendComplaintRepository>(SendComplaintRepository.new);
    i.addLazySingleton<SendComplaintStore>(SendComplaintStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => HomePage(
              store: Modular.get<HomeStore>(),
            ));
    r.child('/complaint-send',
        child: (context) => SendComplaintPage(
              store: Modular.get<SendComplaintStore>(),
            ));
    r.child('/complaint-datails',
        child: (context) => HomeComplaintDetails(
              complaint: r.args.data,
            ));
  }
}
