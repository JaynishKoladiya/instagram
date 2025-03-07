import 'package:flutter/material.dart';
import 'package:instagram/model/user_model.dart';

class PostCard extends StatelessWidget {
  final UserModel user;

  const PostCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            title: Text("${user.firstName} ${user.lastName}"),
            subtitle: Text(user.job),
          ),
          Image.network(
            user.profilePicture,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${user.city}, ${user.country}"),
          ),
        ],
      ),
    );
  }
}
