import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/modules/home/widget/card_complaint_widget.dart';
import 'package:sentinela/app/modules/home/widget/search_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Denúncias"), 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/send-complaint'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
            child: SearchTextField(searchEC, (p0) {}, "Busque por um titulo"),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  shrinkWrap: true,
                  cacheExtent: 3,
                  itemBuilder: (_, index) {
                    return const CardComplaintWidget();
                  }))
        ],
      ),
    );
  }
}
