// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/models/Product.dart';
//
// class FavoriteScreenController extends GetxController {
//   RxList<Product> favorites = <Product>[].obs;
//
//   // Initialize favorites from SharedPreferences
//   Future<void> initFavorites() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String>? favoritesIds = prefs.getStringList('favorites');
//     if (favoritesIds != null) {
//       favorites.assignAll(favoritesIds.map((id) => getProductById(int.parse(id))));
//     }
//   }
//
//   // Toggle favorite status and update SharedPreferences
//   void toggleFavorite(Product product) async {
//     if (favorites.contains(product)) {
//       favorites.remove(product);
//     } else {
//       favorites.add(product);
//     }
//
//     // Save favorites to SharedPreferences
//     final List<String> favoritesIds = favorites.map((product) => product.id.toString()).toList();
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('favorites', favoritesIds);
//
//     update(); // Notify GetBuilder listeners that the favorites list has changed
//   }
//
//   // Helper method to get a product by ID (replace this with your data source logic
// }
