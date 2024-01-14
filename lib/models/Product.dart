import 'package:flutter/material.dart';

class Product {
  String? image, title, description;
  int? id;
  double? price;
  Rating? rating;
  bool isFavorite;

  Product(
      {
        required this.image,
        required this.title,
        required this.description,
        required this.price,
        required this.id,
        required this.isFavorite,
        required this.rating}
      );

  factory Product.fromJson(Map<String, dynamic> json) {
    dynamic price = json['price'];
    final Rating defaultRating = Rating(rate: 0.0, count: 0);
    if (price is int) {
      return Product(
        id: json['id'],
        title: json["title"],
        description: json["description"],
        price: price.toDouble(),
        rating: json['rating'] != null ? Rating.fromJson(json['rating']) : defaultRating,
        image: json['image'], isFavorite: false,
      );
    } else if (price is double) {
      return Product(
        id: json['id'],
        title: json["title"],
        description: json["description"],
        price: price,
        rating: json['rating'] != null ? Rating.fromJson(json['rating']) : defaultRating,
        image: json['image'], isFavorite: false,
      );
    } else {
      // Handle the case where price is neither int nor double
      throw FormatException("Unexpected type for 'price'");
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
    };

    if (rating != null) {
      data['ratings'] = rating!.toJson();
    }
    return data;
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    dynamic rate = json['rate'];
    if (rate is int) {
      return Rating(
        rate: rate.toDouble(),
        count: json['count'],
      );
    } else if (rate is double) {
      return Rating(
        rate: rate,
        count: json['count'],
      );
    } else {
      // Handle the case where rate is neither int nor double
      throw FormatException("Unexpected type for 'rate'");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}