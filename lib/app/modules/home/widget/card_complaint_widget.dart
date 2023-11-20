import 'package:flutter/material.dart';
import 'package:sentinela/app/core/extensions/date_time_extension.dart';
import 'package:sentinela/app/core/extensions/capitalize_text.dart';

import '../../../core/ui/colors.dart';

class CardComplaintWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String createAt;
  const CardComplaintWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.createAt,
  });
  @override
  Widget build(BuildContext context) {
    final DateTime dateParser = DateTime.parse(createAt);
    return Padding(
      padding: const EdgeInsets.only(right: 26.0, left: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    child: SizedBox(
                      width: 126,
                      height: 100,
                      child: Image.network(image),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.capitalize(),
                        maxLines: 3,
                        textWidthBasis: TextWidthBasis.parent,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.green,
                            letterSpacing: 0.6),
                      ),
                      Text(
                        description,
                        maxLines: 1,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.date_range),
                          const SizedBox(width: 4),
                          Text(dateParser.formatDate)
                        ],
                      )
                    ],
                  ))
                ],
              )
            ]),
      ),
    );
  }
}
