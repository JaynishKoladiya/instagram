import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:instagram/model/user_model.dart';


class HomeController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  int offset = 0;
  final int limit = 5;
  final int totalUsers = 1000;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    if (isLoading.value || users.length >= totalUsers) return;

    isLoading(true);
    final url =
        'https://api.slingacademy.com/v1/sample-data/users?offset=$offset&limit=$limit';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> userList = data['users'];

        users.addAll(userList.map((json) => UserModel.fromJson(json)).toList());
        offset += limit;
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading(false);
    }
  }
}
