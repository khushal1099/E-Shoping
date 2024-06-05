import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice1/controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.cartList.length,
            itemBuilder: (context, index) {
              var data = controller.cartList[index];
              print(data.toJson());
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Image.network(data.images?[0]),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data.title}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                "Price:- ${data.price}",
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Obx(
                                    () => Text(
                                    "Total:- ${(data.price!) * (controller.productWiseQty[data.id]?.toDouble() ?? 1)}"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.updateQty(data.id, false);
                                },
                                icon: Icon(
                                  Icons.remove,
                                ),
                              ),
                              Obx(() {
                                return Text(
                                    "${controller.productWiseQty.value[data.id] ?? 1}");
                              }),
                              IconButton(
                                onPressed: () {
                                  controller.updateQty(data.id, true);
                                },
                                icon: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Net Total :-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Obx(
                () {
                  RxDouble NTotal = 0.0.obs;
                  controller.cartList.forEach(
                    (element) {
                      NTotal.value += (element.price! *
                          (controller.productWiseQty.value[element.id]
                                  ?.toDouble() ??
                              1));
                    },
                  );
                  return Text(
                    NTotal.value.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
