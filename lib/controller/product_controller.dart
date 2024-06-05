import 'package:get/get.dart';

class ProductController extends GetxController {
  int? id;
  String? title;
  num? price;
  num? discount;
  num? rating;
  int? stock;
  String? description;
  String? brand;
  String? category;
  List<dynamic>? images;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      id = Get.arguments["id"];
      title = Get.arguments["title"];
      price = Get.arguments["price"];
      discount = Get.arguments["discount"];
      rating = Get.arguments["rating"];
      stock = Get.arguments["stock"];
      description = Get.arguments["description"];
      brand = Get.arguments["brand"];
      category = Get.arguments["category"];
      images = Get.arguments["images"];
    }
  }
}