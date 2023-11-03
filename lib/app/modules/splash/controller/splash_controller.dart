import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/fp/either.dart';
import 'package:sentinela/app/modules/splash/repository/i_splash_repository.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/shared_user_service.dart';
import '../exceptions/splash_repository_exception.dart';

class SplashController {
  final ISplashRepository repository;
  final SharedUserService shared;

  SplashController(this.repository, this.shared);

  Future<void> createUser() async {
    final bool userExists = await shared.checkExistUser();
    switch (userExists) {
      case true:
        Modular.to.navigate("/home/");
      case false:
        final result = await repository.createUser();
        switch (result) {
          case Sucess(:final UserModel value):
            await shared.saveUser(value);
            Modular.to.navigate("/onboard");
          case Failure(:final SplashRepositoryException exception):
            Modular.to.navigate("/error", arguments: exception);
        }
    }
    return;
  }
}
