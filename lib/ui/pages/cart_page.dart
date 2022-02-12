import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nike_store_demo/core/controllers/cart_page_controller.dart';
import 'package:nike_store_demo/core/models/sneaker_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartPageController cartPageController = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          "Cart".toUpperCase(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: cartPageController.cart.isEmpty
          ? Center(
              child: Text(
                "No items in cart".toUpperCase(),
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    itemCount: cartPageController.cart.length,
                    itemBuilder: (context, index) {
                      CartSneaker sneaker = cartPageController.cart[index];
                      return buildCartItems(
                          context: context, sneaker: sneaker, index: index);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Check Out".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: EdgeInsets.symmetric(
                        horizontal: (screenWidth / 2) - 80, vertical: 10),
                    primary: cartPageController.cart[0].color,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }

  buildCartItems(
      {required BuildContext context,
      required CartSneaker sneaker,
      required int index}) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: sneaker.color,
            icon: Icons.delete_forever,
            foregroundColor: Colors.white,
            label: "Remove",
          )
        ],
      ),
      child: Container(
          height: 100,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: sneaker.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image(
                    image: AssetImage(sneaker.imageLocation),
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        sneaker.name.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        sneaker.type.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Text(
                              "color : ".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(color: sneaker.color),
                            ),
                          ],
                        ),
                      ),
                      Text(sneaker.price)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: sneaker.color,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      height: 25,
                      width: 25,
                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      sneaker.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: sneaker.color,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      height: 25,
                      width: 25,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
