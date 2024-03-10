import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/controllers/bottom_navigation.dart';
import 'package:ilocca_v2/screens/business_screen.dart';
import 'package:ilocca_v2/screens/home_screen..dart';
import 'package:ilocca_v2/styles/app_colors.dart';

//create an array of all your screens
//the order matters
var screens = [
  HomeScreen(),
  BusinessScreen(),
  // Center(child: Text("Profile")),
  Center(child: Text("Innovation")),
  Center(child: Text("Events")),
];

//we access our controller
//controller will help us rebuild our UI with the clicked screen
// obx wraps only one child and helps rebuild UI even without stateful widgets
MainBottomNavigationController bottomNavigationController =
    Get.put(MainBottomNavigationController());

class MainWrapperScreen extends StatelessWidget {
  const MainWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => Center(
            child: screens[bottomNavigationController.selectedPage.value]),
      )),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: secondaryTxtColor,
        buttonBackgroundColor: primaryTxtColor,
        color: darkBgColor,
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.business,
            color: Colors.white,
          ),
          Icon(
            Icons.laptop,
            color: Colors.white,
          ),
          Icon(
            Icons.event,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          //we just access the updateFunction and give it index
          bottomNavigationController.updateSelectedPage(index);
        },
      ),
    );
  }
}
