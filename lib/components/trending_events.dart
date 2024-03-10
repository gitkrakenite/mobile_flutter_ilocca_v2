import 'package:flutter/material.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

class TrendingEvents extends StatelessWidget {
  const TrendingEvents({super.key});

  // Dummy data for ads
  static final List<Map<String, String>> ads = [
    {
      'image':
          'https://images.pexels.com/photos/1857308/pexels-photo-1857308.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Mr. Residence'
    },
    {
      'image':
          'https://images.pexels.com/photos/667200/pexels-photo-667200.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Culture Week'
    },
    {
      'image':
          'https://images.pexels.com/photos/917594/pexels-photo-917594.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'JupiterColors'
    },
    {
      'image':
          'https://images.pexels.com/photos/5677356/pexels-photo-5677356.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Color Fest'
    },
    {
      'image':
          'https://images.pexels.com/photos/445109/pexels-photo-445109.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Speak It'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ads.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildAdCard(ads[index]),
        );
      },
    );
  }

  Widget _buildAdCard(Map<String, String> ad) {
    return Container(
      width: 250.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              ad['image']!, // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),

          // Overlay with Semi-Transparent Color
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              color:
                  Colors.black.withOpacity(0.8), // Adjust the opacity as needed
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          child: const Icon(
                            Icons.phone,
                            color: primaryTxtColor,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        const phoneNumber =
                            'tel:+1234567890'; // Replace with the actual phone number

                        // Convert the phone number string to a Uri object
                        final uri = Uri(
                            scheme: 'tel',
                            path:
                                '+1234567890'); // Replace with the actual phone number

                        // Check if the URL can be launched
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: primaryTxtColor,
                                size: 28.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "10",
                                style: TextStyle(
                                  color: primaryTxtColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text(
                      ad['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
