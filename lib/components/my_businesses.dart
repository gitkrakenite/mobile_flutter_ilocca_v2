import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilocca_v2/controllers/user_controller.dart';
import 'package:ilocca_v2/screens/specific_business.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

//acces the userdetails state
UserDetailsController userDetailsController = Get.put(UserDetailsController());

dynamic business_owner = userDetailsController.username.value;

class AllMyBusinesses extends StatefulWidget {
  const AllMyBusinesses({super.key});

  @override
  State<AllMyBusinesses> createState() => _AllMyBusinessesState();
}

class _AllMyBusinessesState extends State<AllMyBusinesses> {
  late Future<List<Map<String, dynamic>>> ads;

  @override
  void initState() {
    super.initState();
    ads = fetchAds();
  }

  Future<List<Map<String, dynamic>>> fetchAds() async {
    final url = Uri.parse('$base_url/biz/mine');

    // Prepare the body
    final body = jsonEncode({
      'business_owner': business_owner,
    });

    // Prepare the headers
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((ad) {
        return {
          'title': ad['title'] as String,
          'photo': ad['photo'] as String,
          'business_owner': ad['business_owner'] as String,
          'business_desc': ad['business_desc'] as String,
          'business_location': ad['business_location'] as String,
          'category': ad['category'] as String,
          'phone': ad['phone'] as String,
          'business_id': ad['business_id'] as int,
        };
      }).toList();
    } else {
      throw Exception('Failed to load ads');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ads,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildAdCard(snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificBusiness(
              title: ad["title"].toString(),
              photo: ad["photo"].toString(),
              owner: ad["business_owner"].toString(),
              business_desc: ad["business_desc"].toString(),
              business_location: ad["business_location"].toString(),
              category: ad["category"].toString(),
              phone: ad["phone"].toString(),
              business_id: ad["business_id"].toString(), // convert to string
            ),
          ),
        );
      },
      child: Container(
        width: 250.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                ad['photo']!, // Replace with your image asset path
                fit: BoxFit.cover,
                height: 200,
              ),
            ),

            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad['title']!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
