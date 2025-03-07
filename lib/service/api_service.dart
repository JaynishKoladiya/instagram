import 'package:http/http.dart' as http;
import 'package:instagram/model/user_model.dart';
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      "https://api.slingacademy.com/v1/sample-data/users";

  static Future<List<UserModel>> fetchUsers(int offset, int limit) async {
    final response =
    await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<UserModel> users =
      (data['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      return users;
    } else {
      throw Exception("Failed to load users");
    }
  }
}
