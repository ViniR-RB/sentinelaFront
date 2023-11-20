import 'package:flutter/material.dart';
import 'package:sentinela/app/modules/splash/controller/splash_controller.dart';

import '../../core/constants/app_assets_path.dart';

class SplashPage extends StatefulWidget {
  final SplashController controller;
  const SplashPage({super.key, required this.controller});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.createUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssetsPath.background),
      ),
    );
  }
}
