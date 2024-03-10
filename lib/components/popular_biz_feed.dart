import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ilocca_v2/screens/specific_business.dart';

var businesses = [
  {
    "id": "1",
    "title": "Comrades",
    "photo":
        "https://images.pexels.com/photos/618079/pexels-photo-618079.jpeg?auto=compress&cs=tinysrgb&w=400",
    "owner": "kiprop"
  },
  {
    "id": "2",
    "title": "My Business",
    "photo":
        "https://images.pexels.com/photos/1367269/pexels-photo-1367269.jpeg?auto=compress&cs=tinysrgb&w=400",
    "owner": "mercy"
  },
  {
    "id": "3",
    "title": "Dacing one",
    "photo":
        "https://images.pexels.com/photos/1438072/pexels-photo-1438072.jpeg?auto=compress&cs=tinysrgb&w=400",
    "owner": "kiprop"
  },
  {
    "id": "4",
    "title": "Jump 2",
    "photo":
        "https://images.pexels.com/photos/1438072/pexels-photo-1438072.jpeg?auto=compress&cs=tinysrgb&w=400",
    "owner": "alexis"
  },
  {
    "id": "5",
    "title": "business 4",
    "photo":
        "https://images.pexels.com/photos/3184419/pexels-photo-3184419.jpeg?auto=compress&cs=tinysrgb&w=400",
    "owner": "manu"
  },
];

class PopularBiz extends StatelessWidget {
  const PopularBiz({super.key});

  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 14),
        itemCount: (businesses.length / 2)
            .ceil(), // Calculate the number of rows needed
        itemBuilder: (context, index) {
          int startIndex = index * 2;
          int endIndex = (index + 1) * 2;
          endIndex =
              endIndex > businesses.length ? businesses.length : endIndex;

          return Column(
            children: [
              Row(
                children: [
                  buildBusinessItem(context, businesses[startIndex]),
                  SizedBox(width: 16), // Adjust the spacing between items
                  if (endIndex < businesses.length)
                    buildBusinessItem(context, businesses[endIndex]),
                ],
              ),
            ],
          );
        },
      ),
    ));
  }
}

Widget buildBusinessItem(BuildContext context, Map<String, String> business) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificBusiness(
              title: business["title"]!,
              photo: business["photo"]!,
              owner: business["owner"]!,
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
            "Owner: ${business["owner"]}",
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
