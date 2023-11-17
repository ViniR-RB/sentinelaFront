import 'package:sentinela/app/modules/home/exceptions/send_repository_exception_location.dart';

sealed class SendComplaintState {}

final class SendComplaintInitialState implements SendComplaintState {}

final class SendComplaintLoadingState implements SendComplaintState {}

final class SendComplaintSendState implements SendComplaintState {}

final class SendComplaintErrorState implements SendComplaintState {
  final SendComplaintRepositoryException e;
  SendComplaintErrorState(this.e);
}
