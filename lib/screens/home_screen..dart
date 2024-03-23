import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/components/ads_component.dart';
import 'package:ilocca_v2/components/trending_events.dart';
import 'package:ilocca_v2/components/user_avatar.dart';
import 'package:ilocca_v2/controllers/app_theme.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

final MainAppTheme appTheme = Get.find<MainAppTheme>();

bool isSwitch = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello John 👋",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/profile");
                      },
                      child: const UserAvatar(
                        path:
                            "https://images.pexels.com/photos/39866/entrepreneur-startup-start-up-man-39866.jpeg?auto=compress&cs=tinysrgb&w=400",
                        size: 50,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Access To Businesses",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Set Up Your Hustle Today",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "#Discover #Elevate",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: primaryTxtColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Image.asset(
                              "assets/images/home.gif",
                              height: 200,
                              width: double.infinity,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Innovate, Inspire, Impact",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "The future is innovations.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "#theFuture #innovate",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: primaryTxtColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Image.asset(
                              "assets/images/innovate.png",
                              height: 200,
                              width: double.infinity,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Interact, Connect, Live a Little",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "We belive in collaborations",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "#network #connect",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: primaryTxtColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Image.asset(
                              "assets/images/events.png",
                              height: 200,
                              width: double.infinity,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "You Should See this 😎",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),

                AdComponent(),

//======================tREDNING EVENTS=========================

                const Text(
                  "Trending Events",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),

                const SizedBox(
                  height: 30,
                ),

                const SizedBox(
                  height: 250,
                  child: TrendingEvents(),
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
