import 'package:ilocca_v2/screens/add_biz_screen.dart';
import 'package:ilocca_v2/screens/login.dart';
import 'package:ilocca_v2/screens/main_wrapper.dart';
import 'package:ilocca_v2/screens/my_profile.dart';
import 'package:ilocca_v2/screens/register_screen.dart';

class AppRoutes {
  static final pages = {
    login: (context) => const LoginScreen(),
    main: (context) => const MainWrapperScreen(),
    editProfile: (context) => const MyProfile(),
    register: (context) => const RegisterSceen(),
    addBiz: (context) => const AddNewBusiness(),
  };

  static const login = '/';
  static const register = '/register';
  static const main = '/main';
  static const addBiz = '/add';
  static const editProfile = '/profile';
  static const user = '/user';
}
