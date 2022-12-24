import 'dart:convert';

Post postFromMap(String str) => Post.fromMap(json.decode(str));

String postToMap(Post data) => json.encode(data.toMap());

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
