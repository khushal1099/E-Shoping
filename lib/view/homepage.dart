import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:practice1/api/ApiProvider.dart';
import 'package:practice1/controller/cart_controller.dart';
import 'package:practice1/utils/SizeUtils.dart';
import 'package:practice1/view/cartpage.dart';
import 'package:practice1/view/detailpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    SizeUtils.config();
    ApiProvider.getProduct((list) {
      cartController.dataList.value = list ?? [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Product",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => CartPage());
                },
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                ),
              ),
              Obx(
                () => cartController.cartList.length == 0
                    ? SizedBox.shrink()
                    : Positioned(
                        right: 5,
                        top: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              cartController.cartList.length.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
          builder: (c) {
            if (cartController.dataList.value.isEmpty) {
              return Container(
                height: SizeUtils.height,
                width: SizeUtils.width,
                child: Lottie.asset(
                  "animations/loading_anim.json",
                ),
              );
            }
            return ListView(
              children: [
                Container(
                  width: SizeUtils.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      cartController.searchProducts(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: "Search Products",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.sList.length,
                    itemBuilder: (context, index) {
                      var data = cartController.sList[index];
                      return Center(
                        child: Card(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => DetailPage(data: data),
                                transition: Transition.cupertino,
                              );
                            },
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextWidget(content: data.title.toString()),
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.network(
                                        data.images?[0],
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String? label;
  final String content;

  const TextWidget({super.key, this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        label != null
            ? Text(
                "${label}:- ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              )
            : SizedBox.shrink(),
        Text(
          "${content}",
          maxLines: 4,
        ),
      ],
    );
  }
}
