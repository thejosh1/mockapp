import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/Product.dart';

class SharedPreferencesHelper {
  static const String favoritesKey = 'favorites';

  static Future<List<Product>> getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favoritesString = prefs.getString(favoritesKey);

    if (favoritesString != null) {
      final Iterable decoded = jsonDecode(favoritesString);

      if (decoded is List && decoded.every((item) => item is Map<String, dynamic>)) {
        List<Product> favorites = [];

        for (var item in decoded) {
          favorites.add(Product.fromJson(item));
        }

        return favorites;
      } else {
        print("Invalid data format in SharedPreferences");
      }
    } else {
      print("Favorites string is null");
    }

    return [];
  }


  static Future<void> addToFavorites(Product product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> favorites = await getFavorites();
    print(favorites[2].rating!.count);
    // Check if the product is not already in favorites
    if (!favorites.contains(product)) {
      print(product.rating!.rate);
      favorites.add(product);
      print(favorites[1].rating!.rate);
      final String favoritesString = jsonEncode(favorites.map((e) => e.toJson()).toList());
      prefs.setString(favoritesKey, favoritesString);
    }
  }

  static Future<void> removeFromFavorites(Product product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> favorites = await getFavorites();

    favorites.remove(product);
    final String favoritesString = jsonEncode(favorites.map((e) => e.toJson()).toList());
    prefs.setString(favoritesKey, favoritesString);
  }
}
