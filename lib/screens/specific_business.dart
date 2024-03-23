import 'package:flutter/material.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

class SpecificBusiness extends StatelessWidget {
  final String title;
  final String photo;
  final String owner;

  const SpecificBusiness({
    super.key,
    required this.title,
    required this.photo,
    required this.owner,
  });

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                photo,
                height: 220.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Owner: $owner',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
