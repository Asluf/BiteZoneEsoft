import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bite_zone/services/bite_zone_db_service.dart';
import 'package:bite_zone/models/user_model.dart';

class AuthService {
  final String baseUrl = 'https://bitezone.onrender.com/api';

  Future<void> login(String email, String password) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/public/login'),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        final userData = responseData['data'];
        final user = User(
          id: userData['_id'],
          name: userData['name'],
          role: userData['role'],
          email: userData['email'],
          token: userData['token'],
        );
        await BiteZoneDBService.instance.insertUserWithToken(user.toMap());
        print("Login successful");
      } else {
        throw Exception(
            'Login failed: ${responseData['error'] ?? 'Unknown error'}');
      }
    } else {
      throw Exception('Failed to login, status code: ${response.statusCode}');
    }
  }

  Future<void> registerUser(String name, String email, String password) async {
    await _register(name, email, password, 'USER');
  }

  Future<void> registerWasteCollector(
      String name, String email, String password) async {
    await _register(name, email, password, 'WASTE_COLLECTOR');
  }

  Future<void> _register(
      String name, String email, String password, String role) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/public/register'),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        print("Registered successfully");
      } else {
        throw Exception(
            'Registration failed: ${responseData['error'] ?? 'Unknown error'}');
      }
    } else {
      throw Exception(
          'Failed to register, status code: ${response.statusCode}');
    }
  }

  Future<void> logout() async {
    await BiteZoneDBService.instance.deleteUser();
  }
}
