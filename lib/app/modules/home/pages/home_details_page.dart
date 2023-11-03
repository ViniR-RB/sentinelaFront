import 'package:flutter/material.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';

class HomeComplaintDetails extends StatelessWidget {
  final ComplaintModel complaint;
  const HomeComplaintDetails({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complaint Details")),
    );
  }
}
