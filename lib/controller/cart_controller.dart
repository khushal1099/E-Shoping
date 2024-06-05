import 'package:get/get.dart';
import 'package:practice1/model/product_model.dart';

class CartController extends GetxController {
  RxList<Product> cartList = <Product>[].obs;
  RxList<Product> sList = <Product>[].obs;
  RxList<Product> dataList = <Product>[].obs;
  RxMap<int, int> productWiseQty = RxMap();
  RxDouble offset = 0.0.obs;

  @override
  void onInit() {
    sList.value = dataList;
    super.onInit();
  }

  void updateQty(int? id, bool addQty) {
    productWiseQty.putIfAbsent(id!, () => 1);
    int qty = productWiseQty[id] ?? 1;
    if (addQty) {
      qty++;
    } else {
      qty--;
    }
    if (qty < 1) qty = 1;
    productWiseQty[id] = qty;
    productWiseQty.refresh();
    print([id, productWiseQty]);
  }

  void removeProduct(int index) {
    if (cartList[index].qty! > 1) {
      cartList[index].qty = (cartList[index].qty ?? 1) - 1;
      cartList.refresh();
    }
  }

  void addProduct(int index) {
    cartList[index].qty = (cartList[index].qty ?? 1) + 1;
    cartList.refresh();
  }

  void searchProducts(String product) {
    List<Product> result = [];
    if (product.isEmpty) {
      result = dataList;
    } else {
      result = dataList
          .where(
            (element) => element.title
                .toString()
                .toLowerCase()
                .contains(product.toLowerCase()),
          )
          .toList();
    }
    sList.value = result;
  }
}
