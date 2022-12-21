import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/data/repository/posts_repository_impl.dart';

import 'posts_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostsRepositoryImpl>()])
void main() {
  ///[testables]
  late PostsRepositoryImpl postsRepository;
  late PostModel post;

  ///[setups]
  setUp(() async {
    postsRepository = MockPostsRepositoryImpl();
    final json = await FixtrueReader().data(name: 'post_json');
    post = PostModel.fromJson(json);
  });

  ///[tests]
  group('Post Repository', () {
    test('[ADD POST]', () async {
      ///[arranges]
      ///[right]
      when(postsRepository.addPost(post: post))
          .thenAnswer((realInvocation) async => const Right(unit));

      ///[left]
      when(postsRepository.addPost(post: post))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      ///[acts]
      final result = await postsRepository.addPost(post: post);

      ///[expects]
      verify(postsRepository.addPost(post: post));
      verifyNoMoreInteractions(postsRepository);
      result.fold(
        (failure) {
          ///[left]
          expect(failure, isA<ServerFailure>());
        },
        (response) {
          ///[right]
          expect(response, unit);
        },
      );
    });

    test('[UPDATE POST]', () async {
      ///[arranges]
      ///[right]
      when(postsRepository.updatePost(post: post))
          .thenAnswer((realInvocation) async => const Right(unit));

      ///[left]
      when(postsRepository.updatePost(post: post))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      ///[acts]
      final result = await postsRepository.updatePost(post: post);

      ///[expects]
      verify(postsRepository.updatePost(post: post));
      verifyNoMoreInteractions(postsRepository);
      result.fold(
        (failure) {
          ///[left]
          expect(failure, isA<ServerFailure>());
        },
        (response) {
          ///[right]
          expect(response, unit);
        },
      );
    });

    test('[DELETE POST]', () async {
      ///[arranges]
      ///[right]
      when(postsRepository.deletePost(postId: post.id!))
          .thenAnswer((realInvocation) async => const Right(unit));

      ///[left]
      when(postsRepository.deletePost(postId: post.id!))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      ///[acts]
      final result = await postsRepository.deletePost(postId: post.id!);

      ///[expects]
      verify(postsRepository.deletePost(postId: post.id!));
      verifyNoMoreInteractions(postsRepository);
      result.fold(
        (failure) {
          ///[left]
          expect(failure, isA<ServerFailure>());
        },
        (response) {
          ///[right]
          expect(response, unit);
        },
      );
    });
    test('[GET POSTS]', () async {
      ///[arranges]
      ///[right]
      when(postsRepository.getPosts())
          .thenAnswer((realInvocation) async => Right([post]));

      ///[left]
      when(postsRepository.getPosts())
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      ///[acts]
      final result = await postsRepository.getPosts();

      ///[expects]
      verify(postsRepository.getPosts());
      verifyNoMoreInteractions(postsRepository);
      result.fold(
        (failure) {
          ///[left]
          expect(failure, isA<ServerFailure>());
        },
        (response) {
          ///[right]
          expect(response.first, equals(post));
        },
      );
    });
  });
}
