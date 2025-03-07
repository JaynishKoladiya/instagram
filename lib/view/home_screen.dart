import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controller/home_controller.dart';
import 'package:instagram/widget/post_card.dart';
import 'package:instagram/widget/story_section.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Clone"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          StorySection(),
          Expanded(
            child: Obx(() => ListView.builder(
              controller: ScrollController()
                ..addListener(() {
                  if (controller.isLoading.value) return;
                  if (controller.users.length < controller.totalUsers) {
                    controller.fetchUsers();
                  }
                }),
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                return PostCard(user: controller.users[index]);
              },
            )),
          ),
        ],
      ),
    );
  }
}
