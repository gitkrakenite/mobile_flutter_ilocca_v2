import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ilocca_v2/screens/specific_business.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

bool isLoading = false;

class PopularBiz extends StatefulWidget {
  const PopularBiz({Key? key}) : super(key: key);

  @override
  _PopularBizState createState() => _PopularBizState();
}

class _PopularBizState extends State<PopularBiz> {
  List<Map<String, dynamic>> businesses = [];

  @override
  void initState() {
    super.initState();
    fetchBusinesses(); // Fetch businesses when the widget initializes
  }

  void fetchBusinesses() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('$base_url/biz'));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> fetchedBusinesses =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      // Shuffle the list of businesses
      fetchedBusinesses.shuffle();

      // Select only the top 5 businesses
      setState(() {
        isLoading = false;
        businesses = fetchedBusinesses.take(5).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load businesses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.halfTriangleDot(
                      color: primaryTxtColor, size: 50),
                  const Text("Fetching ...")
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 14),
              itemCount: (businesses.length / 2).ceil(),
              itemBuilder: (context, index) {
                int startIndex = index * 2;
                int endIndex = min((index + 1) * 2, businesses.length);
                return buildBusinessRow(context, startIndex, endIndex);
              },
            ),
    );
  }

  Widget buildBusinessRow(BuildContext context, int startIndex, int endIndex) {
    return Row(
      children: [
        buildBusinessItem(context, businesses[startIndex]),
        const SizedBox(
          width: 10,
        ),
        if (endIndex - startIndex == 2)
          buildBusinessItem(context, businesses[startIndex + 1]),
      ],
    );
  }

  Widget buildBusinessItem(
      BuildContext context, Map<String, dynamic> business) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecificBusiness(
                title: business["title"].toString(),
                photo: business["photo"].toString(),
                owner: business["business_owner"].toString(),
                business_desc: business["business_desc"].toString(),
                business_location: business["business_location"].toString(),
                category: business["category"].toString(),
                phone: business["phone"].toString(),
                business_id: business["business_id"].toString(),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "${business["photo"]}",
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${business["title"]}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Owner: ${business["business_owner"]}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
