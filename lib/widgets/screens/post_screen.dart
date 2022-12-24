import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/json_place_holder.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: JsonPlaceHolder.getPostById(postId),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('PostById'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (snapshot.connectionState == ConnectionState.waiting)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SpinKitRing(
                    color: Theme.of(context).primaryColor,
                    lineWidth: 3,
                    size: 40,
                  ),
                ),
              if (snapshot.hasError) ...[
                const SizedBox(
                  width: double.infinity,
                  height: 200,
                ),
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 40,
                ),
                Text(
                  'Error Occured\n${snapshot.error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ],
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) ...[
                Text('userId:${snapshot.data!.userId}'),
                Text('postId:${snapshot.data!.id}'),
                Text('title:${snapshot.data!.title}'),
                Text('body:${snapshot.data!.body}'),
              ],
            ],
          ),
        );
      },
    );
  }
}
