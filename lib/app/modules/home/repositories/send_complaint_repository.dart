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

class SendComplaintRepository implements ISendComplaintRepository {
  final Dio _dio;
  final GeolocatorService _geolocatorService;

  SendComplaintRepository(this._geolocatorService, this._dio);
  @override
  Future<Either<SendComplaintRepositoryException, Nil>> sendComplaintByAddres(
      String title, String description, String address, File image) async {
    try {
      Location location =
          await _geolocatorService.determinePositionByAddress(address);
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "title": title,
        "description": description,
        "longitude": location.longitude,
        "latitude": location.latitude,
        "status": "iniciada",
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
          String title, String description, File image) async {
    try {
      final Position position = await _geolocatorService.determinePosition();
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "title": title,
        "description": description,
        "longitude": position.longitude,
        "latitude": position.latitude,
        "status": "iniciada",
        "file": await MultipartFile.fromFile(image.path, filename: fileName)
      });
      await _dio.post("/api/complaint", data: formData);
      return Sucess(Nil());
    } on GeolocatorServiceException catch (e) {
      return Failure(SendComplaintRepositoryException(e.message));
    } catch (e, s) {
      log("Houve um erro inesperado tente novamente", stackTrace: s, error: e);
      return Failure(SendComplaintRepositoryException(
          "Houve um erro inesperado tente novamente"));
    }
  }
}
