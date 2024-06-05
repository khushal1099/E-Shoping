import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SizeUtils{
  SizeUtils._();

  static double height = 0.0;
  static double width = 0.0;

  static config(){
    height = MediaQuery.of(Get.context!).size.height;
    width = MediaQuery.of(Get.context!).size.width;
  }
}