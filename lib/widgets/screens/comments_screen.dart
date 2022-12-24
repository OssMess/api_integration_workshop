import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/json_place_holder.dart';
import '../tiles/comment_tile.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: JsonPlaceHolder.getAllComments(postId),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Comments for Post'),
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
                  snapshot.hasData)
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => CommentTile(
                      comment: snapshot.data!.elementAt(index),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).primaryColor,
                      height: 30,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
