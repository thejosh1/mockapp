import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/data/repository/products_repo.dart';

import '../models/Product.dart';
import '../models/cart_model.dart';
import 'cart_controller.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  final ProductsRepo productsRepo;

  ProductsController({required this.productsRepo});

  List<Product> _productsList = [];
  List<Product> get productsList => _productsList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _itemsInCart = 0;
  int get itemsInCart => _itemsInCart+_quantity;


  Future<void> getProductsList() async {
    try {
      // Make the API call to fetch the products list
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        // If the response is successful, parse the JSON data
        final responseData = json.decode(response.body);

        // Assuming 'data' is the key containing the products array in the response
        final productList = responseData as List<dynamic>;

        // Map the JSON data to a list of Product objects
        final productsList = productList.map((data) => Product.fromJson(data)).toList();

        // Update the local variable with the fetched data
        _productsList = productsList;

        // Set the flag to indicate that data has been loaded
        _isLoaded = true;

        // Notify listeners about the update
        update();
      } else {
        // If the response is not successful, throw an exception
        throw Exception('Failed to fetch products');
      }
    } catch (error) {
      // Catch any exceptions that occur during the process
      throw error;
    }
  }

  void setQuantity(bool isIncrement) {
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("number of items "+ _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("Decrement quantity is now "+ _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if(itemsInCart+quantity < 0 ) {
      Get.snackbar("Items Count", "You can't reduce more",
          backgroundColor: Colors.black,
          colorText: Colors.white
      );
      if(_itemsInCart>0) {
        _quantity = -_itemsInCart;
        return _quantity;
      }
      return 0;
    } else if (itemsInCart+quantity > 20){
      Get.snackbar("Items Count", "You can't add more",
          backgroundColor: Colors.black,
          colorText: Colors.white
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(Product product, CartController cart) {
    _quantity = 0;
    _itemsInCart = 0;
    _cart = cart;
    var _exits = false;
    _exits = _cart.existsInCart(product);
    // print("exists or not" + _exits.toString());

    if(_exits) {
      _itemsInCart = _cart.getQuantity(product);
    }
    // print("quantity in cart " + _itemsInCart.toString());
  }

  void addItem(Product product) {
    if(_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _itemsInCart = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        // print("the id is " + value.id.toString() + " the quantity is " + value.quantity.toString());
        update();
      });
    } else {
      Get.snackbar("Cart", "How many do you want to add",
          backgroundColor: Colors.black,
          colorText: Colors.white
      );
    }

  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}