import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/controllers/app_theme.dart';
import 'package:ilocca_v2/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

MainAppTheme preferredUserTheme = Get.put(MainAppTheme());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iLocca',
      // theme: ThemeData.light().copyWith(
      //   // Light mode theme
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   // Add any additional light mode customization here
      // ),
      // darkTheme: ThemeData.dark().copyWith(
      //   // Dark mode theme
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      //   // Add any additional dark mode customization here
      // ),
      // themeMode: ThemeMode
      //     .system, // Automatically switch between light and dark based on system settings

      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      // themeMode: preferredUserTheme.isDarkMode.value
      //     ? ThemeMode.dark
      //     : ThemeMode.light,
      initialRoute: "/",
      getPages: Routes.routes,
    );
  }
}
