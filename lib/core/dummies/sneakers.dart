import 'package:flutter/material.dart';
import 'package:nike_store_demo/core/models/sneaker_model.dart';
import 'package:nike_store_demo/ui/constants.dart';

List<Sneaker> sneakers = [
  Sneaker(
      type: "Nike Air",
      name: "Air Jordan 1 Mid SE GC",
      price: "\$120.00",
      imageLocation: 'assets/images/J_001.png',
      availableColors: [
        darkYellow,
        bluishTeal,
        Colors.red,
        Colors.green,
      ],
      availableVariantsLocation: [
        'assets/images/J_001.png','assets/images/J_002.png','assets/images/J_003.png','assets/images/J_004.png',
      ],
      mainColor: darkYellow),
  Sneaker(
    type: "Nike Air",
    name: "Nike Blazer Mid",
    price: "\$150.00",
    mainColor: bluishTeal,
    imageLocation: 'assets/images/Z_001.png',
    availableColors: [bluishTeal, Colors.red, darkOrange, Colors.green],
    availableVariantsLocation: [
      'assets/images/Z_001.png', 'assets/images/Z_002.png','assets/images/Z_004.png','assets/images/Z_003.png',
    ],
  ),
  Sneaker(
      type: "Nike Zoom",
      name: "ZoomX Vaporfly",
      price: "\$180.00",
      mainColor: navyGreen,
      availableColors: [navyGreen, Colors.black, marineBlue, Colors.green],
      availableVariantsLocation: [
        'assets/images/N_001.png', 'assets/images/N_003.png','assets/images/N_002.png','assets/images/N_004.png',
      ],
      imageLocation: 'assets/images/N_001.png'),
  Sneaker(
      type: "Nike WMNS",
      name: "WMNS Daybreak",
      price: "\$100.00",
      mainColor: lightRed,
      availableColors: [lightRed, Colors.grey, lightYellow],
      availableVariantsLocation: [
        'assets/images/W_001.png', 'assets/images/W_002.png', 'assets/images/W_003.png',
      ],
      imageLocation: 'assets/images/W_001.png'),
  Sneaker(
      type: "Nike React",
      name: "React Vision",
      price: "\$170.00",
      mainColor: lightPeach,
      availableColors: [lightPeach, Colors.black87, lightYellow],
      availableVariantsLocation: [
        'assets/images/R_001.png', 'assets/images/R_002.png', 'assets/images/R_003.png',
      ],
      imageLocation: 'assets/images/R_001.png'),
];
