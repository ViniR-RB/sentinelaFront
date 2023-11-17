import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sentinela/app/core/services/image_picker_service.dart';
import 'package:sentinela/app/modules/home/controller/send_complaint_controller.dart';
import 'package:sentinela/app/modules/home/repositories/i_send_complaint_repository.dart';
import 'package:sentinela/app/modules/home/states/send_complaint_state.dart';

import '../../../core/fp/either.dart';
import '../exceptions/send_repository_exception_location.dart';

class SendComplaintStore {
  final ImagePickerService _imagePickerService;
  final SendComplaintController _complaintController =
      SendComplaintController();

  final ISendComplaintRepository _repository;
  SendComplaintStore(this._repository, this._imagePickerService);

  ValueNotifier<SendComplaintState> get sendComplaintState =>
      _complaintController;

  sendComplaint(
      String title, String description, bool isGps, String address) async {
    _complaintController.emit(SendComplaintLoadingState());
    if (isGps == true) {
      final result = await _repository.sendComplaintByLatitudeAndLongitude(
          title, description, _imagePickerService.image);
      switch (result) {
        case Sucess():
          _complaintController.emit(SendComplaintSendState());
        case Failure(:final SendComplaintRepositoryException exception):
          _complaintController.emit(SendComplaintErrorState(exception));
      }
    } else {
      final result = await _repository.sendComplaintByAddres(
          title, description, address, _imagePickerService.image);
      switch (result) {
        case Sucess():
          _complaintController.emit(SendComplaintSendState());
        case Failure(:final SendComplaintRepositoryException exception):
          _complaintController.emit(SendComplaintErrorState(exception));
      }
    }
  }

  Future<File> getImage() async {
    await _imagePickerService.getImage();
    return _imagePickerService.image;
  }
}
