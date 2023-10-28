import 'package:flutter/material.dart';

import '../../../core/ui/colors.dart';

class CardComplaintWidget extends StatelessWidget {
  const CardComplaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: SizedBox(
                      width: 126,
                      child: Image.network(
                          "https://catracalivre.com.br/wp-content/uploads/2019/08/amazonia-pegando-fogo.jpg"),
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
                          "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                          maxLines: 3,
                          textWidthBasis: TextWidthBasis.parent,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.green,
                              letterSpacing: 0.6)),
                    ],
                  ))
                ],
              )
            ]),
      ),
    );
  }
}
