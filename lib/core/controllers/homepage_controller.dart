import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store_demo/core/dummies/sneakers.dart';
import 'package:nike_store_demo/core/models/sneaker_model.dart';
import 'package:nike_store_demo/ui/constants.dart';

class HomePageController extends GetxController{
  List categories = ["Basketball", "Running", "Training"];
  List pageColors = [darkYellow, bluishTeal, navyGreen];

  Rx<Color> currentPageColor = sneakers[0].mainColor.obs;

  RxInt indexPage = 0.obs;
  
  void changeCurrentColor(){
    currentPageColor.value = sneakers[indexPage.value].mainColor;
  }

  void addItemToCart({required CartSneaker sneaker, required RxList<CartSneaker> cart}){
    bool exist = false;
    for(int i=0; i<cart.length; i++){
      if(cart[i].imageLocation == sneaker.imageLocation){
        cart[i].quantity++;
        exist = true;
      }
    }
    if(!exist){
      cart.add(sneaker);
    }
  }



}