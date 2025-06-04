import 'dart:convert';
import 'package:crowd_counting_app/core/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/error/failure.dart';

abstract class AuthDataSource {
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> login(String email, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;

  AuthDataSourceImpl({required this.client});

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      return UserModel(email: email, token: token);
    } else {
      final message = jsonDecode(response.body)['message'];
      throw ServerFailure(message);
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['data']['access_token'];
      return UserModel(email: email, token: token);
    } else {
      final message = jsonDecode(response.body)['message'];
      throw ServerFailure(message);
    }
  }
}
