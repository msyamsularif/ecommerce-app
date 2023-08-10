import 'dart:convert';

import 'package:ecommerce_app/core/helpers/constant_name_helpers.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  Future<bool> checkout({
    required String token,
    required List<CartModel> cart,
    required double totalPrice,
  }) async {
    const url =
        ConstantNameHelpers.baseUrl + ConstantNameHelpers.checkoutEndPoint;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final body = jsonEncode({
      'address': 'Marsemoon',
      'items': cart
          .map((e) => {
                'id': e.product.id,
                'quantity': e.qty,
              })
          .toList(),
      'status': 'PENDING',
      'total_price': totalPrice,
      'shipping_price': 0,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to Checkout');
    }
  }
}
