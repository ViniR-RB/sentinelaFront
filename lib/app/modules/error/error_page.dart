import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Exception exception;
  final String message;
  const ErrorPage({super.key, required this.exception, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}
