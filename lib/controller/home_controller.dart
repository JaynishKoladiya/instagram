import 'package:get/get.dart';
import 'package:instagram/model/user_model.dart';
import 'package:instagram/service/api_service.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  var offset = 0;
  final int limit = 5;
  var hasMoreData = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    if (isLoading.value || !hasMoreData.value) return;

    isLoading.value = true;
    try {
      List<UserModel> newUsers = await ApiService.fetchUsers(offset, limit);
      if (newUsers.isNotEmpty) {
        users.addAll(newUsers);
        offset += limit;
      } else {
        hasMoreData.value = false; // No more data to load
      }
    } finally {
      isLoading.value = false;
    }
  }
}
