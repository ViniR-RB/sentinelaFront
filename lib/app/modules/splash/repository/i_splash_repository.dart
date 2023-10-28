import 'package:sentinela/app/core/models/user_model.dart';
import 'package:sentinela/app/modules/splash/exceptions/splash_repository_exception.dart';

import '../../../core/fp/either.dart';

abstract interface class ISplashRepository {
  Future<Either<SplashRepositoryException, UserModel>> createUser();
}
