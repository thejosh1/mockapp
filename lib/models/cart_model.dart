import 'Product.dart';

class CartModel {
  int? id;
  String? title;
  double? price;
  String? img;
  int? quantity;
  String? description;
  bool? isExist;
  String? time;
  Product? product;

  CartModel(
      {this.id,
        this.title,
        this.price,
        this.img,
        this.quantity,
        this.description,
        this.isExist,
        this.time,
        this.product
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    description = json['description'];
    isExist = json['isExist'];
    time = json['time'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": title,
      "price": price,
      "img": img,
      "quantity": quantity,
      "description":description,
      "isExist": isExist,
      "time": time,
      "product": product!.toJson(),
    };
  }
}