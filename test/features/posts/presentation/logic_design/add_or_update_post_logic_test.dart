import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/add_post.dart';
import 'package:unit_testing/features/posts/domain/usecases/update_post.dart';
import 'package:unit_testing/features/posts/presnetation/logic_design/add_or_edit_post/add_or_edit_post_bloc.dart';

import 'add_or_update_post_logic_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddPost>(),
  MockSpec<UpdatePost>(),
  MockSpec<TextEditingController>(),
])
void main() {
  ///[tests]
  late Post post;
  late AddOrEditPostBloc addOrEditPostBloc;
  late AddPost addPost;
  late UpdatePost updatePost;

  ///[setups]
  setUp(() async {
    post = const Post(body: 'body', title: 'title');
    addPost = MockAddPost();
    updatePost = MockUpdatePost();
    addOrEditPostBloc = AddOrEditPostBloc(
      addPosts: addPost,
      updatePosts: updatePost,
      bodyController: MockTextEditingController(),
      titleController: MockTextEditingController(),
    );
  });
  group('AddOrEditPost bloc', () {
    blocTest<AddOrEditPostBloc, AddOrEditPostState>(
      '[ADD POST]',
      build: () {
        when(addPost.addPost(post: post))
            .thenAnswer((realInvocation) async => const Right(unit));
        return addOrEditPostBloc;
      },
      act: (bloc) {
        bloc.submit();
      },
      wait: const Duration(seconds: 1),
      expect: () => <AddOrEditPostState>[
        OnAddOrEditLoadingState(),
        OnAddOrEditDoneState(),
      ],
    );

    blocTest<AddOrEditPostBloc, AddOrEditPostState>(
      '[UPDATE POST]',
      build: () {
        when(updatePost.updatePost(post: post))
            .thenAnswer((realInvocation) async => const Right(unit));
        return addOrEditPostBloc;
      },
      act: (bloc) {
        bloc.submit(post: post);
      },
      wait: const Duration(seconds: 1),
      expect: () => <AddOrEditPostState>[
        OnAddOrEditLoadingState(),
        OnAddOrEditDoneState(),
      ],
    );
  });
}
