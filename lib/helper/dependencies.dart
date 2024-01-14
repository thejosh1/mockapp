import 'package:get/get.dart';
import 'package:shop_app/controller/favorites_screen_controller.dart';
import 'package:shop_app/data/repository/cart_repo.dart';

import '../controller/auth_controller.dart';
import '../controller/cart_controller.dart';
import '../controller/products_controller.dart';
import '../controller/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/products_repo.dart';
import '../data/repository/user_repo.dart';
import '../utils/app_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //shared preferences
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //product repo
  Get.lazyPut(() => ProductsRepo(apiClient: Get.find()));
  //user repo
  Get.lazyPut(() => UserRepo(sharedPreferences: Get.find(), user: Get.find()));
  //auth repo
  Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find()));
  //cart repo
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //products controller
  Get.lazyPut(() => ProductsController(productsRepo: Get.find()));
  //AuthController
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  //UserController
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  //favorite controller
  // Get.lazyPut(() => FavoriteScreenController());
  //cart controller
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}