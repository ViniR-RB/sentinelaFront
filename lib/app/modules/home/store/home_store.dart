import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/modules/home/controller/home_controller.dart';
import 'package:sentinela/app/modules/home/repositories/i_home_repository.dart';
import 'package:sentinela/app/modules/home/states/home_state.dart';

import '../../../core/fp/either.dart';
import '../exceptions/home_repository_exception.dart';

class HomeStore {
  final IHomeRepository repository;
  HomeStore(this.repository);
  final _homeStateController = HomeController();

  Future<void> getAllComplaints() async {
    _homeStateController.emit(HomeLoadingState());
    final result = await repository.getAllComplaint();
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

  ValueNotifier<HomeState> get homeState => _homeStateController;
}
