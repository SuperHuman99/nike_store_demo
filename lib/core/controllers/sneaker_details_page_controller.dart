import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store_demo/core/models/sneaker_model.dart';
import 'package:nike_store_demo/ui/constants.dart';

class SneakerDetailsPageController{

  RxInt currentSize = 0.obs;
  Rx<Color>? currentPageColor;
  RxInt currentPageColorIndex = 0.obs;

  RxBool isFavorite = true.obs;

  List currentSizeHeight = [0.31, 0.34, 0.37, 0.4].obs;
  List currentSizeWidth = [0.81, 0.84, 0.87, 0.9].obs;

  setCurrentColorIndex(int newColor){
    currentPageColorIndex.value = newColor;
  }

  setCurrentPageColor(Sneaker sneaker){
    currentPageColor?.value = sneaker.availableColors[currentPageColorIndex.value] ?? sneaker.mainColor;
  }

  setCurrentSize(int newSize){
    currentSize.value = newSize;
  }

}