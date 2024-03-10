import 'package:flutter/material.dart';
import 'package:get/get.dart';

//we need the index and function to update
class MainAppTheme extends GetxController {
  RxBool isDarkMode = true.obs; //variable to track the current page

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    print(isDarkMode.value);
  }
}
