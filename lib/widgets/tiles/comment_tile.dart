import 'package:flutter/material.dart';

import '../../models/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('postId:${comment.postId}'),
          Text('id:${comment.id}'),
          Text('name:${comment.name}'),
          Text('email:${comment.email}'),
          Text('body:${comment.body}'),
        ],
      ),
    );
  }
}
