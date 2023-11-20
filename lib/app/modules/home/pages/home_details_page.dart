import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentinela/app/core/constants/app_assets_path.dart';
import 'package:sentinela/app/core/extensions/capitalize_text.dart';
import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/core/ui/colors.dart';

class HomeComplaintDetails extends StatelessWidget {
  final ComplaintModel complaint;
  const HomeComplaintDetails({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complaint Details")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 45.0, right: 45, top: 9, bottom: 18),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 309,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: NetworkImage(complaint.image)),
                    borderRadius: const BorderRadius.all(Radius.circular(32))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    complaint.title.capitalize(),
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.black),
                          const SizedBox(width: 12),
                          Text(
                            DateTime.parse(complaint.createdAt)
                                .toLocal()
                                .toString(),
                            style: TextStyle(
                                color:
                                    AppColor.descriptionColor.withOpacity(0.65),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssetsPath.iconBurgerIncomplet,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Status: ${complaint.status.capitalize()}",
                          style: TextStyle(
                              color: AppColor.descriptionColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppAssetsPath.iconBurgerComplet,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            complaint.description,
                            maxLines: 4,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColor.descriptionColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
