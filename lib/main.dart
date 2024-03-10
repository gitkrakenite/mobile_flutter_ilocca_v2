import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/controllers/app_theme.dart';
import 'package:ilocca_v2/utils/routes.dart';

void main() {
  runApp(MyApp());
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
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: preferredUserTheme.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: "/",
      getPages: Routes.routes,
    );
  }
}
