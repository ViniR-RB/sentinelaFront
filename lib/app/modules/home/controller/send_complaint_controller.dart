import 'package:flutter/material.dart';
import 'package:sentinela/app/modules/home/states/send_complaint_state.dart';

class SendComplaintController extends ValueNotifier<SendComplaintState> {
  SendComplaintController() : super(SendComplaintInitialState());

  emit(SendComplaintState state) {
    value = state;
  }
}
