import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/components/popular_biz_feed.dart';
import 'package:ilocca_v2/components/top_business_component.dart';
import 'package:ilocca_v2/screens/all_businesses.dart';
import 'package:ilocca_v2/screens/main_wrapper.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBusinessWidget(),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Popular",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllBusinesses(),
                  ),
                );
              },
              icon: const Icon(Icons.open_in_full),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const PopularBiz(),
      ],
    );
  }
}
