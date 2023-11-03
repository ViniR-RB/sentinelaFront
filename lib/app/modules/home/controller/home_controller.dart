import 'package:flutter/material.dart';

import '../states/home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(HomeInitialState());

  emit(HomeState state) {
    value = state;
    return;
  }
}
