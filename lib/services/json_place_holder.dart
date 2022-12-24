import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment.dart';
import '../models/post.dart';

class JsonPlaceHolder {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static const String posts = '/posts';
  static const String comments = '/comments';

  static Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl$posts',
      ),
    );
    http.StreamedResponse response = await request.send();
    // throw Exception('Oops!');
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(await response.stream.bytesToString());
      return result.map((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<Post> getPostById(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl$posts/$id',
      ),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // Map<String, dynamic> result =
      //     jsonDecode(await response.stream.bytesToString());
      // return Post.fromMap(result);
      return postFromMap(await response.stream.bytesToString());
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<List<Comment>> getAllComments(String postId) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl$posts/$postId$comments',
        // '$baseUrl$comments?postId=$postId',
      ),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(await response.stream.bytesToString());
      return result.map((json) => Comment.fromMap(json)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
