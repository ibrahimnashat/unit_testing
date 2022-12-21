import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/add_post.dart';

import 'add_post_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddPost>(),
])
void main() {
  ///[testables]
  late AddPost addPost;
  late Post post;

  ///[setups]
  setUp(() async {
    addPost = MockAddPost();
    final json = await FixtrueReader().data(name: 'post_json');
    post = PostModel.fromJson(json);
  });

  ///[tests]
  test('Usecase [ADD POST]', () async {
    ///[arranges]
    ///[right]
    when(addPost.addPost(post: post))
        .thenAnswer((realInvocation) async => const Right(unit));

    ///[left]
    when(addPost.addPost(post: post))
        .thenAnswer((realInvocation) async => Left(ServerFailure()));

    ///[acts]
    final result = await addPost.addPost(post: post);

    ///[expects]
    verify(addPost.addPost(post: post));
    verifyNoMoreInteractions(addPost);

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
}
