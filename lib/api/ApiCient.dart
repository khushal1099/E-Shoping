import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

enum ApiMethod { get, post, delete }

class ApiClient {
  ApiClient._();

  static String baseUrl = 'https://dummyjson.com/';

  static String product = 'products';

  static Future<dynamic> call(
    String url, {
    Map<String, String> params = const {},
    ApiMethod apiMethod = ApiMethod.get,
    bool isDebug = false,
    Function(dynamic body)? onResponse,
  }) async {
    var data;
    try {
      var get = await http.get(Uri.parse('$baseUrl$url'));

      if (get.statusCode == 200) {
        data = jsonDecode(get.body);
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    if (isDebug) log('$data');
    if (onResponse != null) onResponse(data);
    return data;
  }
}
