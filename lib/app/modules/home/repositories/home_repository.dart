import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sentinela/app/core/fp/either.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/modules/home/exceptions/home_repository_exception.dart';

import './i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final Dio dio;
  HomeRepository(this.dio);
  @override
  Future<Either<HomeRepositoryException, List<ComplaintModel>>>
      getAllComplaint() async {
    try {
      final Response(:data) = await dio.get<List<dynamic>>("/api/complaint");
      print(data);
      final complaintList =
          data!.map((e) => ComplaintModel.fromMap(e)).toList();
      return Sucess(complaintList);
    } on DioException catch (e) {
      log("Houve um Problema com a requisição",
          error: e, stackTrace: e.stackTrace);
      return Failure(
          HomeRepositoryException("Houve um Problema a lista de Denúncias"));
    } catch (e) {
      log("Houve um Error inesperado", error: e);
      return Failure(HomeRepositoryException("Houve um Error inesperado"));
    }
  }
}
