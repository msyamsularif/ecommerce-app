import 'dart:convert';

import 'package:ecommerce_app/core/helpers/constant_name_helpers.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    const url =
        ConstantNameHelpers.baseUrl + ConstantNameHelpers.productEndPoint;
    const headers = {'Content-Type': 'application/json'};

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data']['data'];

      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();

      return products;
    } else {
      throw Exception('Failed to Get Products');
    }
  }
}
