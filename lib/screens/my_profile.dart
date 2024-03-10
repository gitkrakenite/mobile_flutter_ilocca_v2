import 'package:flutter/material.dart';
import 'package:ilocca_v2/components/trending_events.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.network(
                    'https://images.pexels.com/photos/1366909/pexels-photo-1366909.jpeg?auto=compress&cs=tinysrgb&w=400', // Replace with your image asset path
                    fit: BoxFit.cover,
                  ),
                ),

                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2 - 31,
                  child: // profile Image
                      ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Image.network(
                        'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=400',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello Josh",
                      style: TextStyle(color: secondaryTxtColor),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/edit-profile");
                      },
                      icon: const Icon(Icons.edit, color: primaryTxtColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "You have three businesses",
                  style: TextStyle(
                      color: secondaryTxtColor.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 250,
                  child: TrendingEvents(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
