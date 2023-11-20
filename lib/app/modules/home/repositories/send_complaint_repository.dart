import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sentinela/app/core/exceptions/geolocator_service_exception.dart';
import 'package:sentinela/app/core/fp/either.dart';
import 'package:sentinela/app/core/fp/nil.dart';
import 'package:sentinela/app/core/services/geolocator_service.dart';
import 'package:sentinela/app/modules/home/exceptions/send_repository_exception_location.dart';
import 'package:sentinela/app/modules/home/repositories/i_send_complaint_repository.dart';

import '../../../core/models/organs_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/shared_user_service.dart';

class SendComplaintRepository implements ISendComplaintRepository {
  final SharedUserService _sharedUserService;
  final Dio _dio;
  final GeolocatorService _geolocatorService;

  SendComplaintRepository(
      this._geolocatorService, this._dio, this._sharedUserService);
  @override
  Future<Either<SendComplaintRepositoryException, Nil>> sendComplaintByAddres(
      String title,
      String description,
      String address,
      String organId,
      File image) async {
    try {
      Location location =
          await _geolocatorService.determinePositionByAddress(address);
      String fileName = image.path.split('/').last;
      final UserModel? user = await _sharedUserService.getUser();
      FormData formData = FormData.fromMap({
        "title": title,
        "description": description,
        "longitude": location.longitude,
        "latitude": location.latitude,
        "status": "iniciada",
        "organId": organId,
        "userId": user!.id,
        "file": await MultipartFile.fromFile(image.path, filename: fileName)
      });
      await _dio.post("/api/complaint", data: formData);
      return Sucess(Nil());
    } on GeolocatorServiceException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      return Failure(SendComplaintRepositoryException(e.message));
    } catch (e, s) {
      log("Houve um erro inesperado tente novamente", stackTrace: s, error: e);
      return Failure(SendComplaintRepositoryException(
          "Houve um erro inesperado tente novamente"));
    }
  }

  @override
  Future<Either<SendComplaintRepositoryException, Nil>>
      sendComplaintByLatitudeAndLongitude(
          String title, String description, String organId, File image) async {
    try {
      final Position position = await _geolocatorService.determinePosition();
      String fileName = image.path.split('/').last;
      final UserModel? user = await _sharedUserService.getUser();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName),
        "description": description,
        "longitude": position.longitude,
        "latitude": position.latitude,
        "status": "iniciada",
        "title": title,
        "organId": organId,
        "userId": user!.id,
      });
      await _dio.post("/api/complaint", data: formData);
      return Sucess(Nil());
    } on DioException catch (e, s) {
      log("Houve um problema com envio da denúncia", error: e, stackTrace: s);
      return Failure(SendComplaintRepositoryException(
          "Houve um problema com envio da denúncia"));
    } on GeolocatorServiceException catch (e) {
      return Failure(SendComplaintRepositoryException(e.message));
    } catch (e, s) {
      log("Houve um erro inesperado tente novamente", stackTrace: s, error: e);
      return Failure(SendComplaintRepositoryException(
          "Houve um erro inesperado tente novamente"));
    }
  }

  @override
  Future<Either<SendComplaintRepositoryException, List<OrgansModel>>>
      getAllOrgansIdAndNames() async {
    try {
      final request = await _dio.get<List<dynamic>>("/api/organ");
      final data = request.data;
      final organsList = data!.map((e) => OrgansModel.fromMap(e)).toList();
      return Sucess(organsList);
    } on ArgumentError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      return Failure(SendComplaintRepositoryException(e.message));
    } on DioException catch (e) {
      log("Houve um Problema com a requisição",
          error: e, stackTrace: e.stackTrace);
      return Failure(SendComplaintRepositoryException(
          "Houve um Problema em pegar a lista de Orgãos"));
    }
  }
}
