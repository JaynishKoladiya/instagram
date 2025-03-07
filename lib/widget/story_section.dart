import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controller/home_controller.dart';

class StorySection extends StatelessWidget {
  final HomeController controller = Get.find();

  StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          final user = controller.users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                SizedBox(height: 5),
                Text(user.firstName, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    ));
  }
}
