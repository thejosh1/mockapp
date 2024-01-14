import 'package:get/get.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../models/Product.dart';
import '../screens/auth/login_page.dart';
import '../screens/auth/registration_screen.dart';
import '../screens/main_page.dart';
import '../screens/splash/splash_screen.dart';

class RouteHelper{
  static const SPLASHSCREEN = "/splash-screen";
  static const HOME = "/";
  static const PRODUCTDETAILS = "/product-details-screen";
  static const REGISTER = "/register";
  static const LOGIN = "/login";

  static String getSplashScreen() => "$SPLASHSCREEN";
  static String getHome() => "$HOME";
  static String getProductDetailScreen() => "$PRODUCTDETAILS";
  static String getRegistration() => "$REGISTER";
  static String getLogin() => "$LOGIN";

  static List<GetPage> ROUTES = [
    GetPage(name: SPLASHSCREEN, page: ()=>const SplashScreen()),
    GetPage(name: HOME, page: () {
      return MainPage();
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: REGISTER, page: () {
      return SignUpPage();
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: LOGIN, page: () {
      return LoginPage();
    },
        transition: Transition.fadeIn
    )
  ];
}