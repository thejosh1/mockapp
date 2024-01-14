import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/controller/products_controller.dart';
import 'package:shop_app/controller/user_controller.dart';
import 'package:shop_app/screens/main_page.dart';
import 'package:shop_app/utils/constants.dart';
import 'package:shop_app/routes/route_helper.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartdata();
    return GetBuilder<ProductsController>(builder: (_) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: MainPage(),
        initialRoute: RouteHelper.SPLASHSCREEN,
        getPages: RouteHelper.ROUTES,
      );
    });
  }
}
