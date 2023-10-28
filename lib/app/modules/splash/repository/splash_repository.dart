import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sentinela/app/core/fp/either.dart';
import 'package:sentinela/app/core/models/user_model.dart';
import 'package:sentinela/app/modules/splash/exceptions/splash_repository_exception.dart';

import 'i_splash_repository.dart';

class SplashRepositoryImpl implements ISplashRepository {
  final Dio dio;
  SplashRepositoryImpl(this.dio);
  @override
  Future<Either<SplashRepositoryException, UserModel>> createUser() async {
    try {
      final Response<Map> response = await dio.post("/api/user");
      final Map data = response.data!;
      final UserModel user = UserModel.fromMap(data);
      return Sucess(user);
    } on ArgumentError catch (e) {
      log(e.message, error: e, stackTrace: e.stackTrace);
      return Failure(SplashRepositoryException(e.message, e.stackTrace));
    } on DioException catch (e) {
      log("Houve um erro na requisição", error: e, stackTrace: e.stackTrace);
      return Failure(SplashRepositoryException(
          e.message ?? "Houve um Erro inesperado", e.stackTrace));
    }
  }
}
