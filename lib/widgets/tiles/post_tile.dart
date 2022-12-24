import 'package:flutter/material.dart';

import '../../models/post.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('userId:${post.userId}'),
          Text('postId:${post.id}'),
          Text('title:${post.title}'),
          Text('body:${post.body}'),
        ],
      ),
    );
  }
}
