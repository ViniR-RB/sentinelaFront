import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/modules/home/states/home_state.dart';
import 'package:sentinela/app/modules/home/store/home_store.dart';
import 'package:sentinela/app/modules/home/widget/card_complaint_widget.dart';
import 'package:sentinela/app/modules/home/widget/search_text_field.dart';

class HomePage extends StatefulWidget {
  final HomeStore store;
  const HomePage({super.key, required this.store});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.store.getAllComplaints();
    });
  }

  final searchEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Denúncias"),
        actions: [
          IconButton(
              onPressed: () => widget.store.getAllComplaints(),
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/home/complaint-send'),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
          valueListenable: widget.store.homeState,
          builder: (context, value, child) {
            return switch (value) {
              HomeInitialState() => SizedBox.fromSize(),
              HomeLoadingState() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              HomeLoadedState(:final complaintList) => Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                      child: SearchTextField(searchEC, (String title) {
                        widget.store.searchTitleComplaint(title);
                      }, "Busque por um titulo"),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                        child: ListView.builder(
                            itemCount: complaintList.length,
                            padding: const EdgeInsets.only(top: 8, bottom: 24),
                            shrinkWrap: true,
                            cacheExtent: 3,
                            itemBuilder: (_, index) {
                              final ComplaintModel complaint =
                                  complaintList[index];
                              return GestureDetector(
                                onTap: () => Modular.to.pushNamed(
                                    "/home/complaint-datails",
                                    arguments: complaint),
                                child: CardComplaintWidget(
                                  image: complaint.image,
                                  description: complaint.description,
                                  title: complaint.title,
                                  createAt: complaint.createdAt,
                                ),
                              );
                            }))
                  ],
                ),
              HomeLoadedEmptyState() => const Center(
                  child: Text("Não há nenhuma denúncia"),
                )
            };
          }),
    );
  }
}
