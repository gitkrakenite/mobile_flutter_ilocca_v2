import 'package:ilocca_v2/screens/login.dart';
import 'package:ilocca_v2/screens/main_wrapper.dart';
import 'package:ilocca_v2/screens/my_profile.dart';

class AppRoutes {
  static final pages = {
    login: (context) => const LoginScreen(),
    main: (context) => const MainWrapperScreen(),
    editProfile: (context) => const MyProfile(),
  };

  static const login = '/';
  static const main = '/main';
  static const editProfile = '/profile';
  static const nearby = '/nearby';
  static const user = '/user';
}
