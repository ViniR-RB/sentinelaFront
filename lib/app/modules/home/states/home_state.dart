import 'package:sentinela/app/core/models/complaint_model.dart';

sealed class HomeState {}

final class HomeInitialState implements HomeState {}

final class HomeLoadingState implements HomeState {}

final class HomeLoadedState implements HomeState {
  final List<ComplaintModel> complaintList;
  HomeLoadedState(this.complaintList);
}

final class HomeLoadedEmptyState implements HomeState {}
