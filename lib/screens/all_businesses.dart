import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/screens/specific_business.dart';
import 'package:http/http.dart' as http;
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

bool isLoading = false;

class AllBusinesses extends StatefulWidget {
  const AllBusinesses({Key? key}) : super(key: key);

  @override
  _AllBusinessesState createState() => _AllBusinessesState();
}

class _AllBusinessesState extends State<AllBusinesses> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredBusinesses = [];
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
      setState(() {
        isLoading = false;
        businesses =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        // print(businesses);
        filteredBusinesses = List.from(businesses);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load businesses');
    }
  }

  void _filterBusinesses(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBusinesses = List.from(businesses);
      } else {
        filteredBusinesses = businesses
            .where((business) =>
                business["title"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Businesses'),
      ),
      body: isLoading
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterBusinesses,
                    decoration: const InputDecoration(
                      hintText: 'Search Businesses',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredBusinesses.length,
                    itemBuilder: (context, index) {
                      return BusinessListItem(
                        business: filteredBusinesses[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpecificBusiness(
                                title: filteredBusinesses[index]["title"]
                                    .toString(),
                                photo: filteredBusinesses[index]["photo"]
                                    .toString(),
                                owner: filteredBusinesses[index]
                                        ["business_owner"]
                                    .toString(),
                                business_desc: filteredBusinesses[index]
                                        ["business_desc"]
                                    .toString(),
                                business_location: filteredBusinesses[index]
                                        ["business_location"]
                                    .toString(),
                                category: filteredBusinesses[index]["category"]
                                    .toString(),
                                phone: filteredBusinesses[index]["phone"]
                                    .toString(),
                                business_id: filteredBusinesses[index]
                                        ["business_id"]
                                    .toString(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

//Responsible for UI
class BusinessListItem extends StatelessWidget {
  final Map<String, dynamic> business;
  final VoidCallback onTap;

  BusinessListItem({required this.business, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4, // Add elevation to the card
      margin: EdgeInsets.all(8), // Add margin for spacing
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                business["photo"].toString(),
                fit: BoxFit.cover,
                height: 220, // Adjust the height as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    business["title"].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Owner: ${business["business_owner"].toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
