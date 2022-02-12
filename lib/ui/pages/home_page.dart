import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store_demo/core/controllers/cart_page_controller.dart';
import 'package:nike_store_demo/core/controllers/homepage_controller.dart';
import 'package:nike_store_demo/core/dummies/sneakers.dart';
import 'package:nike_store_demo/core/models/sneaker_model.dart';
import 'package:nike_store_demo/ui/pages/cart_page.dart';
import 'package:nike_store_demo/ui/pages/sneaker_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController homePageController = Get.put(HomePageController());
  CartPageController cartPageController = Get.put(CartPageController());

  late PageController pageController;

  void _listener() {
    homePageController.indexPage.value = pageController.page!.round();
    homePageController.changeCurrentColor();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.85);
    pageController.addListener(_listener);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appBarHeight = 0.09 * screenHeight;
    double itemWidgetRadius = 0.1 * screenWidth;
    double customBottomNavBarHeight = 0.1 * screenHeight;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        elevation: 0.5,
        title: SizedBox(
          height: 0.8 * appBarHeight,
          width: 0.2 * screenWidth,
          child: const Image(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/nike_w.png'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CartPage());
            },
            icon: Obx(
              () => Badge(
                badgeContent: Text("${cartPageController.cart.length}"),
                child: const Icon(Icons.shopping_bag_outlined, size: 32),
              ),
            ),
          ),
          const SizedBox(width: 40),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu, size: 32)),
          SizedBox(width: 0.05 * screenWidth),
        ],
      ),
      body: Column(
        children: [
          buildCategoryWidget(),
          Expanded(
            child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemCount: sneakers.length,
                itemBuilder: (context, index) {
                  Sneaker sneaker = sneakers[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Obx(() => GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => SneakerDetailsPage(sneaker: sneaker));
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(
                                  bottom: 0.05 * screenHeight,
                                  top: index ==
                                          homePageController.indexPage.value
                                      ? 0.03 * screenHeight
                                      : 0.06 * screenHeight),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(itemWidgetRadius),
                                ),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: itemWidgetRadius,
                                        horizontal: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sneaker.type.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            sneaker.name.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          sneaker.price.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Text(
                                            sneaker.type.toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 124,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black26),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: constraints.maxHeight * 0.18,
                                    child: Hero(
                                      tag: sneaker.name,
                                      child: Image(
                                        image:
                                            AssetImage(sneaker.imageLocation),
                                        height: 0.85 * screenWidth,
                                        width: 0.85 * screenWidth,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        homePageController.addItemToCart(
                                            sneaker: CartSneaker(
                                                type: sneaker.type,
                                                name: sneaker.name,
                                                price: sneaker.price,
                                                color: sneaker.mainColor,
                                                quantity: 1,
                                                imageLocation: sneaker
                                                    .availableVariantsLocation[0]),
                                            cart: cartPageController.cart);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: sneaker.mainColor,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  itemWidgetRadius),
                                              topLeft: Radius.circular(
                                                  itemWidgetRadius),
                                            )),
                                        height: 0.25 * screenWidth,
                                        width: 0.25 * screenWidth,
                                        child: const Icon(
                                          Icons.add,
                                          size: 42,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                    }),
                  );
                }),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 0.05 * screenWidth, vertical: 10.0),
              height: customBottomNavBarHeight,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(0.5 * customBottomNavBarHeight),
                  color: homePageController.currentPageColor.value,
                  boxShadow: [
                    BoxShadow(
                        color: homePageController.currentPageColor.value
                            .withOpacity(0.2),
                        offset: const Offset(0, 0),
                        spreadRadius: 6.0,
                        blurRadius: 20.0)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.home_rounded,
                        size: 38, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.radio_button_checked_outlined,
                        size: 38, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.person, size: 38, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryWidget() {
    return SizedBox(
      height: 70,
      child: Row(
        children: homePageController.categories
            .asMap()
            .entries
            .map(
              (e) => e.key == 0
                  ? Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          e.value,
                          style: TextStyle(
                            color: homePageController.indexPage.value <= 1
                                ? homePageController.currentPageColor.value
                                : Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : e.key == 1
                      ? Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              e.value,
                              style: TextStyle(
                                color: homePageController.indexPage.value > 1 &&
                                        homePageController.indexPage.value < 4
                                    ? homePageController.currentPageColor.value
                                    : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              e.value,
                              style: TextStyle(
                                color: homePageController.indexPage.value >= 4
                                    ? homePageController.currentPageColor.value
                                    : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
            )
            .toList(),
      ),
    );
  }
}
