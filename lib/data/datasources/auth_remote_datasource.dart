import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/error/failure.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(
        'https://reqres.in/api/login',
      ), // Ganti sesuai endpoint asli kamu
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      return UserModel(email: email, token: token);
    } else {
      throw ServerFailure('Login gagal: ${response.body}');
    }
  }
}
