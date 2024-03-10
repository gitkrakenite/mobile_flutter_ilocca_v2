import 'package:get/get.dart';
import 'package:ilocca_v2/screens/add_biz_screen.dart';
import 'package:ilocca_v2/screens/all_businesses.dart';
// import 'package:ilocca_v2/screens/home_screen..dart';
import 'package:ilocca_v2/screens/login.dart';
import 'package:ilocca_v2/screens/main_wrapper.dart';
import 'package:ilocca_v2/screens/my_profile.dart';

class Routes {
  static var routes = [
    GetPage(name: "/", page: () => const LoginScreen()),
    GetPage(name: "/home", page: () => const MainWrapperScreen()),
    GetPage(name: "/profile", page: () => const MyProfile()),
    GetPage(name: "/addBiz", page: () => const AddNewBusiness()),
  ];
}
