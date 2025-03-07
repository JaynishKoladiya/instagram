import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controller/home_controller.dart';
import 'package:instagram/model/user_model.dart';
class HomeScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Clone", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStorySection(),
          Expanded(child: _buildPostList()),
        ],
      ),
    );
  }

  // Story Section UI
  Widget _buildStorySection() {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Obx(() {
        if (userController.users.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            final user = userController.users[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.profilePicture),
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.firstName,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  /// Post List UI with Pagination
  Widget _buildPostList() {
    return Obx(() {
      if (userController.users.isEmpty && userController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!userController.isLoading.value &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            userController.fetchUsers();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: userController.users.length + 1,
          itemBuilder: (context, index) {
            if (index == userController.users.length) {
              return userController.hasMoreData.value
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox.shrink();
            }
            final user = userController.users[index];
            return _buildPostCard(user);
          },
        ),
      );
    });
  }

  // Post Card UI
  Widget _buildPostCard(UserModel user) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            title: Text("${user.firstName} ${user.lastName}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(user.job),
            trailing: Icon(Icons.more_vert),
          ),
          Image.network(
            user.profilePicture,
            width: double.infinity,
            height: 500,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 28),
                    SizedBox(width: 15),
                    Icon(Icons.comment_outlined, size: 28),
                    SizedBox(width: 15),
                    Icon(Icons.send, size: 28),
                  ],
                ),
                Icon(Icons.bookmark_border, size: 28),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "${user.firstName} ${user.lastName} - ${user.job}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
