import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/modules/home/controller/home_controller.dart';
import 'package:sentinela/app/modules/home/repositories/i_home_repository.dart';
import 'package:sentinela/app/modules/home/states/home_state.dart';

import '../../../core/fp/either.dart';
import '../../../core/services/geolocator_service.dart';
import '../exceptions/home_repository_exception.dart';

class HomeStore {
  final IHomeRepository _repository;
  final GeolocatorService _geolocatorService;

  HomeStore(this._repository, this._geolocatorService);
  final _homeStateController = HomeController();
  final List<ComplaintModel> _complaintList = [];
  Future<void> getAllComplaints() async {
    _homeStateController.emit(HomeLoadingState());
    final result = await _repository.getAllComplaint();
    switch (result) {
      case Sucess(:final List<ComplaintModel> value):
        if (value.isEmpty) {
          _homeStateController.emit(HomeLoadedEmptyState());
        } else {
          _homeStateController.emit(HomeLoadedState(value));
          _complaintList.addAll(value);
        }
      case Failure(:final HomeRepositoryException exception):
        Modular.to.navigate("/error", arguments: exception);
    }

    return;
  }

  void searchTitleComplaint(String titleComplaint) {
    if (titleComplaint.isEmpty || titleComplaint == "") {
      _homeStateController.emit(HomeLoadedState(_complaintList));
    } else {
      final filteredList = _complaintList
          .where((element) => element.title
              .toLowerCase()
              .contains(titleComplaint.toLowerCase()))
          .toSet()
          .toList();

      _homeStateController.emit(
        HomeLoadedState(
          filteredList,
        ),
      );
    }
  }

  Future<Position> determinePosition() async {
    final Position position = await _geolocatorService.determinePosition();
    return position;
  }

  ValueNotifier<HomeState> get homeState => _homeStateController;
}
