import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/components/user_avatar.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

class TopBusinessWidget extends StatelessWidget {
  const TopBusinessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Container(
            height: 220,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.network(
                    'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&w=400', // Replace with your image asset path
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay with Semi-Transparent Color
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'iLocca',
                              style: TextStyle(
                                color: primaryTxtColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Get.toNamed("/addBiz");
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 30,
                                      color: secondaryTxtColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Navigator.of(context)
                                        //     .pushReplacementNamed("/");
                                        print("Notifications tapped");
                                      },
                                      icon: const Icon(
                                        Icons.notifications,
                                        size: 30,
                                        color: secondaryTxtColor,
                                      ),
                                    ),
                                    const Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                            color: primaryTxtColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          "Hey, John! Let us help you discover local businesses and service providers",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
