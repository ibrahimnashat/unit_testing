import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';

import 'posts_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostsRemoteDataSource>()])
void main() {
  ///[testables]
  late PostsRemoteDataSource remoteDataSource;
  late List<PostModel> posts;

  ///[setups]
  setUp(() async {
    remoteDataSource = MockPostsRemoteDataSource();
    final post = await FixtrueReader().data(name: 'post_json');
    posts = [PostModel.fromJson(post)];
  });

  ///[tests]
  group('Remote data source', () {
    test('[GET POSTS]', () async {
      ///[arranges]
      when(remoteDataSource.getPosts())
          .thenAnswer((realInvocation) async => posts);

      ///[acts]
      final result = await remoteDataSource.getPosts();

      ///[expects]
      verify(remoteDataSource.getPosts());
      verifyNoMoreInteractions(remoteDataSource);
      expect(posts.first, result.first);
    });
    test('[ADD POST]', () async {
      ///[arranges]
      when(remoteDataSource.addPost(post: posts.first))
          .thenAnswer((realInvocation) async => unit);

      ///[acts]
      final result = await remoteDataSource.addPost(post: posts.first);

      ///[expects]
      verify(remoteDataSource.addPost(post: posts.first));
      verifyNoMoreInteractions(remoteDataSource);
      expect(result, unit);
    });
    test('[DELETE POST]', () async {
      ///[arranges]
      when(remoteDataSource.deletePost(postId: 1))
          .thenAnswer((realInvocation) async => unit);

      ///[acts]
      final result = await remoteDataSource.deletePost(postId: 1);

      ///[expects]
      verify(remoteDataSource.deletePost(postId: 1));
      verifyNoMoreInteractions(remoteDataSource);
      expect(result, unit);
    });
    test('[UPDATE POST]', () async {
      ///[arranges]
      when(remoteDataSource.updatePost(post: posts.first))
          .thenAnswer((realInvocation) async => unit);

      ///[acts]
      final result = await remoteDataSource.updatePost(post: posts.first);

      ///[expects]
      verify(remoteDataSource.updatePost(post: posts.first));
      verifyNoMoreInteractions(remoteDataSource);
      expect(result, unit);
    });
  });
}
