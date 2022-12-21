import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_testing/core/injection/injection.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/presnetation/logic_design/add_or_edit_post/add_or_edit_post_bloc.dart';

class AddOrDeleteOrEditPostScreen extends StatelessWidget {
  final Post? post;
  final _bloc = getIt<AddOrEditPostBloc>();

  AddOrDeleteOrEditPostScreen({
    super.key,
    this.post,
  }) {
    if (post != null) {
      _bloc.setEditValues(post!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          post != null ? 'Edit Post' : 'Add Post',
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            TextField(
              key: const Key('post-title'),
              decoration: const InputDecoration(hintText: 'title'),
              controller: _bloc.titleController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                key: const Key('post-body'),
                decoration: const InputDecoration(hintText: 'body'),
                controller: _bloc.bodyController,
                maxLines: 3,
              ),
            ),
            BlocBuilder<AddOrEditPostBloc, AddOrEditPostState>(
              bloc: _bloc,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: state is OnAddOrEditLoadingState
                      ? const CircularProgressIndicator(
                          key: Key('add-post-loader'),
                          color: Colors.blue,
                        )
                      : TextButton(
                          onPressed: () => _bloc.submit(post: post),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
