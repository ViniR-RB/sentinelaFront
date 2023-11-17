import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/modules/home/controller/home_controller.dart';
import 'package:sentinela/app/modules/home/repositories/i_home_repository.dart';
import 'package:sentinela/app/modules/home/states/home_state.dart';

import '../../../core/fp/either.dart';
import '../../../core/services/geolocator_service.dart';
import '../../../core/services/image_picker_service.dart';
import '../exceptions/home_repository_exception.dart';

class HomeStore {
  final IHomeRepository _repository;
  final GeolocatorService _geolocatorService;
  final ImagePickerService _imagePickerService;
  HomeStore(
      this._repository, this._geolocatorService, this._imagePickerService);
  final _homeStateController = HomeController();

  Future<void> getAllComplaints() async {
    _homeStateController.emit(HomeLoadingState());
    final result = await _repository.getAllComplaint();
    switch (result) {
      case Sucess(:final List<ComplaintModel> value):
        if (value.isEmpty) {
          _homeStateController.emit(HomeLoadedEmptyState());
        } else {
          _homeStateController.emit(HomeLoadedState(value));
        }
      case Failure(:final HomeRepositoryException exception):
        Modular.to.navigate("/error", arguments: exception);
    }

    return;
  }

  /* Future<(HomeRepositoryException? exception, Location? value)>
      searchFromAddress(String address) async {
    final result = await _repository.searchFromAddress(address);
    switch (result) {
      case Sucess(:final Location value):
        return (null, value);
      case Failure(:final HomeRepositoryException exception):
        return (exception, null);
    }
  } */

  Future<Position> determinePosition() async {
    final Position position = await _geolocatorService.determinePosition();
    return position;
  }

  Future<File> getImage() async {
    await _imagePickerService.getImage();
    return _imagePickerService.image;
  }

  /* Future<void> sendComplaint(
      String title, String description, bool isUseGps, String? addres) async {
    Position position;
    Location location;
    if (isUseGps == true) {
      position = await determinePosition();
      await _repository.sendComplaint(
          title,
          description,
          position.longitude.toString(),
          position.latitude.toString(),
          _imagePickerService.image);
    } else {
      final (HomeRepositoryException? exception, Location? value) =
          await searchFromAddress(addres!);

      if (exception == null) {
        location = value!;
        await _repository.sendComplaint(
            title,
            description,
            location.longitude.toString(),
            location.latitude.toString(),
            _imagePickerService.image);
      }
    }
  } */

  ValueNotifier<HomeState> get homeState => _homeStateController;
}
