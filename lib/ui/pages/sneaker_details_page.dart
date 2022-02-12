import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store_demo/core/controllers/sneaker_details_page_controller.dart';
import 'package:nike_store_demo/core/models/sneaker_model.dart';

class SneakerDetailsPage extends StatefulWidget {
  const SneakerDetailsPage({Key? key, required this.sneaker}) : super(key: key);

  final Sneaker sneaker;

  @override
  _SneakerDetailsPageState createState() => _SneakerDetailsPageState();
}

class _SneakerDetailsPageState extends State<SneakerDetailsPage>
    with TickerProviderStateMixin {
  SneakerDetailsPageController sneakerPageController =
      Get.put(SneakerDetailsPageController());

  Color? currentPageColor;

  late AnimationController iconAnimationController;
  late AnimationController descriptionAnimationController;

  late Animation<double> iconAnimation;
  late Animation<double> descriptionAnimation;

  @override
  void initState() {
    super.initState();
    iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    descriptionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    iconAnimation = Tween<double>(begin: 1, end: 1.2)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(iconAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          iconAnimationController.reverse();
        }
      });

    descriptionAnimation = Tween<double>(begin: 1.5, end: 1)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(descriptionAnimationController)
      ..addListener(() {
        setState(() {});
      });

    descriptionAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -0.05 * screenWidth,
            right: -0.40 * screenWidth,
            child: Container(
              height: 0.5 * screenHeight,
              width: 0.5 * screenHeight,
              decoration: BoxDecoration(
                color: currentPageColor ?? widget.sneaker.mainColor,
                borderRadius: BorderRadius.circular(0.25 * screenHeight),
              ),
            ),
          ),
          Positioned(
            top: 0.05 * screenHeight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.05 * screenWidth),
              height: 70,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 55,
                    width: 55,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: iconAnimation.value,
                    child: Obx(() => GestureDetector(
                      onTap: () {
                        iconAnimationController.forward();
                        sneakerPageController.isFavorite.value = !sneakerPageController.isFavorite.value;
                      },
                      child: Icon(
                        Icons.favorite_outlined,
                        color: sneakerPageController.isFavorite.value ? Colors.white : Colors.red,
                        size: 36,
                      ),
                    ),)
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.25 * screenHeight,
            left: 0.05 * screenWidth,
            child: Text(
              widget.sneaker.type.toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 140,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 0.15 * screenHeight,
            child: SizedBox(
              width: screenWidth,
              height: 0.4 * screenHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.sneaker.name,
                    child: Obx(
                      () => Image(
                        image: AssetImage(widget
                                .sneaker.availableVariantsLocation[
                            sneakerPageController.currentPageColorIndex.value]),
                        height: sneakerPageController.currentSizeHeight[
                                sneakerPageController.currentSize.value] *
                            screenHeight,
                        width: sneakerPageController.currentSizeWidth[
                                sneakerPageController.currentSize.value] *
                            screenWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.62 * screenHeight,
            child: Transform.scale(
              scale: descriptionAnimation.value,
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sneaker.type.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.sneaker.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.sneaker.price,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    buildStarsWidget(),
                    Text(
                      "size".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    buildSizeWidget(),
                    const SizedBox(height: 40),
                    Text(
                      "color".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    buildAvailableColorsWidget(
                        screenWidth: screenWidth, sneaker: widget.sneaker),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAvailableColorsWidget(
      {required double screenWidth, required Sneaker sneaker}) {
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              sneaker.availableColors.length,
              (index) => GestureDetector(
                onTap: () {
                  sneakerPageController.setCurrentColorIndex(index);
                  setState(() {
                    currentPageColor = widget.sneaker.availableColors[
                        sneakerPageController.currentPageColorIndex.value];
                  });
                },
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: widget.sneaker.availableColors[index],
                      borderRadius: BorderRadius.circular(25),
                      border: index ==
                              sneakerPageController.currentPageColorIndex.value
                          ? Border.all(color: Colors.white70, width: 4)
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: currentPageColor ?? widget.sneaker.mainColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              ),
              child: Text(
                "Buy".toUpperCase(),
                style: const TextStyle(fontSize: 24, color: Colors.white70),
              ))
        ],
      ),
    );
  }

  Widget buildSizeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: List.generate(
          4,
          (index) => GestureDetector(
            onTap: () {
              sneakerPageController.setCurrentSize(index);
            },
            child: Obx(() => Container(
                  margin: const EdgeInsets.only(right: 15.0),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: index == sneakerPageController.currentSize.value
                        ? currentPageColor ?? widget.sneaker.mainColor
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      (index + 7).toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget buildStarsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: List.generate(
          5,
          (index) => Icon(
            Icons.star_rounded,
            size: 42,
            color: index == 4
                ? Colors.white
                : currentPageColor ?? widget.sneaker.mainColor,
          ),
        ),
      ),
    );
  }
}
