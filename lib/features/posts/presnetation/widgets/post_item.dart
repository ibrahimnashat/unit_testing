import 'package:flutter/material.dart';
import 'package:unit_testing/core/injection/injection.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/presnetation/logic_design/add_or_edit_post/add_or_edit_post_bloc.dart';
import 'package:unit_testing/features/posts/presnetation/logic_design/home/post_bloc.dart';
import 'package:unit_testing/features/posts/presnetation/views/add_or_edit_post_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final PostBloc bloc;
  const PostItem({
    super.key,
    required this.post,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddOrDeleteOrEditPostScreen(
              post: post,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Id : ${post.id}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            Text(
              post.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                post.body,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ),
            const Divider(color: Colors.black),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => bloc.deletePost(post: post),
                    child: const Text(
                      'Delete Post',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1.0,
                  height: 30.0,
                  color: Colors.grey,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Edit Post",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
