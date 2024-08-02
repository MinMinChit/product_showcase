import 'dart:developer' as dev;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:product_showcase/constants/constants.dart';

class ProductServices {
  Future<http.Response> getProductCategory() async {
    dev.log('[Product Services] Get product category');
    final response = await http.get(
      Uri.parse('${MyConstant.url}/products/categories'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    dev.log('[Product Services] ${response.body}');

    return response;
  }

  Future<http.Response> getProductCategoryItems(String category) async {
    dev.log('[Product Services] Get product items by category');
    final response = await http.get(
      Uri.parse('${MyConstant.url}/products/category/$category'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    dev.log('[Product Services] ${response.body}');

    return response;
  }
}
