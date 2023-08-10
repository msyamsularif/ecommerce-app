import 'dart:convert';

import 'package:ecommerce_app/core/helpers/constant_name_helpers.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    const url =
        ConstantNameHelpers.baseUrl + ConstantNameHelpers.registerEndPoint;
    const headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final token = 'Bearer ${data['access_token']}';

      UserModel user = UserModel.fromJson(data['user'], token);

      return user;
    } else {
      throw Exception('Failed to Register');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    const url = ConstantNameHelpers.baseUrl + ConstantNameHelpers.loginEndPoint;
    const headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final token = 'Bearer ${data['access_token']}';

      UserModel user = UserModel.fromJson(data['user'], token);

      return user;
    } else {
      throw Exception('Failed to Login');
    }
  }
}
