import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:practice1/controller/cart_controller.dart';
import 'package:practice1/view/cartpage.dart';
import 'package:practice1/view/homepage.dart';

import '../model/product_model.dart';

class DetailPage extends StatelessWidget {
  final Product data;

  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Hero(
        tag: "hero",
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: data.images?.length,
                  itemBuilder: (context, index, realIndex) {
                    var imageList = data.images?[index];
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(
                        imageList!,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOut,
                    clipBehavior: Clip.antiAlias,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.9,
                    enlargeFactor: 0.2,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      bool isAdded = cartController.cartList
                          .any((index) => index.id == data.id);
                      if (!isAdded) {
                        cartController.cartList.add(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: const Text("Product Added to Cart"),
                            backgroundColor: Colors.green,
                            action: SnackBarAction(
                              label: "view",
                              onPressed: () {
                                Get.to(() => const CartPage());
                              },
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: const Text("Product is Already in Cart"),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: "view",
                              onPressed: () {
                                Get.to(() => const CartPage());
                              },
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextWidget(
                            label: "Id",
                            content: "${data.id}",
                          ),
                          TextWidget(
                            label: "Title",
                            content: "${data.title}",
                          ),
                          TextWidget(
                            label: "Price",
                            content: "${data.price}",
                          ),
                          TextWidget(
                            label: "Discount",
                            content: "${data.discountPercentage}%",
                          ),
                          TextWidget(
                            label: "Stock",
                            content: "${data.stock}",
                          ),
                          TextWidget(
                            label: "Brand",
                            content: "${data.brand}",
                          ),
                          TextWidget(
                            label: "Category",
                            content: "${data.category}",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Rating:- ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              RatingBar.builder(
                                itemCount: 5,
                                initialRating: data.rating!.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 20,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (value) {
                                  print(value);
                                },
                              ),
                            ],
                          ),
                          Container(
                            width: 368,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Description:- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
