import 'package:flutter/material.dart';

class Sneaker {
  final String type;
  final String name;
  final String price;
  final String imageLocation;
  final Color mainColor;
  final List availableColors;
  final List availableVariantsLocation;

  Sneaker({
    required this.type,
    required this.name,
    required this.price,
    required this.imageLocation,
    required this.availableColors,
    required this.mainColor,
    required this.availableVariantsLocation,
  });
}

class CartSneaker {
  final String name;
  final String type;
  final String price;
  final Color color;
  final String imageLocation;
  int quantity;

  CartSneaker({
    required this.type,
    required this.name,
    required this.price,
    required this.color,
    required this.imageLocation,
    required this.quantity,
  });
}
