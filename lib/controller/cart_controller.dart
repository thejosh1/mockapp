import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/Product.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items= {};

  Map<int, CartModel> get items=> _items;

  List<CartModel> storageItems = [];

  void addItem(Product product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            title: value.title,
            price: value.price,
            img: value.img,
            isExist: true,
            description: value.description,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            product: product
        );
      });
      if(totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if(quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            title: product.title,
            price: product.price,
            img: product.image,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("Cart", "You haven't added any item to cart",
            backgroundColor: Colors.black54,
            colorText: Colors.white
        );
      }
    }
    cartRepo.addToCarList(getItems);
    update();
  }

  bool existsInCart(Product product) {
    if(_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(Product product) {
    var quantity = 0;
    if(_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if(key==product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  int get totalAmount {
    var totalprice = 0;
    _items.forEach((key, value) {
      totalprice += value.quantity!*value.price!.toInt();
    });

    return totalprice;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<CartModel> getCartdata() {
    setCart = cartRepo.getCartList();

    return storageItems;
  }

  set setCart(List<CartModel> item) {
    storageItems = item;
    // print("Number of items is "+storageItems.length.toString());
    for(int i = 0; i<storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addtoCartHistoryList() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getcartHistoryList();
  }

  void addToCartList() {
    cartRepo.addToCarList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}