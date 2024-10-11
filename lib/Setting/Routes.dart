import 'package:get/get.dart';

import '../Views/Auth/LoginScreen.dart';
import '../Views/Auth/SignInScreen.dart';
import '../Views/Home/Pages/HomePageScreen.dart';
import '../Views/Luncher/SeplashScreenHome.dart';
import '../Views/Home/Projects/AddProjcetsScreen.dart';
import '../Views/Home/Projects/GetProjectsScreens.dart';

class AppPage {
  static List<GetPage> routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/homePageScreen',
      page: () => HomePageScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeSeplashScreen(),
    ),
    GetPage(
      name: '/register',
      page: () => SignScreen(),
    ),
    GetPage(
      name: '/addProject',
      page: () => AddProjectsScreen(),
    ),
    GetPage(
      name: '/getProject',
      page: () => GetProjectsScreen(),
    ),
  ];
}
