import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/screens/specific_business.dart';

class AllBusinesses extends StatefulWidget {
  const AllBusinesses({Key? key}) : super(key: key);

  @override
  _AllBusinessesState createState() => _AllBusinessesState();
}

class _AllBusinessesState extends State<AllBusinesses> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredBusinesses = [];
  final List<Map<String, String>> businesses = [
    {
      "id": "1",
      "title": "Comrades",
      "photo":
          "https://images.pexels.com/photos/20426237/pexels-photo-20426237/free-photo-of-a-couple-holding-hands-and-walking-on-a-beach.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
      "owner": "kiprop"
    },
    {
      "id": "2",
      "title": "My Business",
      "photo":
          "https://images.pexels.com/photos/17832031/pexels-photo-17832031/free-photo-of-a-person-is-walking-along-the-beach-near-the-ocean.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
      "owner": "mercy"
    },
    {
      "id": "3",
      "title": "Dancing one",
      "photo":
          "https://images.pexels.com/photos/20410779/pexels-photo-20410779/free-photo-of-a-wooden-walkway-in-the-middle-of-a-jungle.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
      "owner": "kiprop"
    },
    {
      "id": "4",
      "title": "Jump 2",
      "photo":
          "https://images.pexels.com/photos/19166222/pexels-photo-19166222/free-photo-of-rolling-hills.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
      "owner": "alexis"
    },
    {
      "id": "5",
      "title": "Business 4",
      "photo":
          "https://images.pexels.com/photos/2220255/pexels-photo-2220255.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
      "owner": "manu"
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredBusinesses = List.from(businesses);
  }

  void _filterBusinesses(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBusinesses = List.from(businesses);
      } else {
        filteredBusinesses = businesses
            .where((business) =>
                business["title"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Businesses'),
      ),
      body: Column(
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
                    Get.to(
                      () => SpecificBusiness(
                        title: filteredBusinesses[index]["title"]!,
                        photo: filteredBusinesses[index]["photo"]!,
                        owner: filteredBusinesses[index]["owner"]!,
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
  final Map<String, String> business;
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
                business["photo"]!,
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
                    business["title"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Owner: ${business["owner"]}",
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
