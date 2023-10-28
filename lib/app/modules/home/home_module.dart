import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/modules/home/home_page.dart';
import 'package:sentinela/app/modules/home/pages/send_complaint_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/send-complaint', child: (context) => const SendComplaintPage());
  }
}
