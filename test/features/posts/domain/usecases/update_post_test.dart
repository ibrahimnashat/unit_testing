import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/update_post.dart';

import 'update_post_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UpdatePost>(),
])
void main() {
  ///[testables]
  late UpdatePost updatePost;
  late Post post;

  ///[setups]
  setUp(() async {
    updatePost = MockUpdatePost();
    final json = await FixtrueReader().data(name: 'post_json');
    post = PostModel.fromJson(json);
  });

  ///[tests]
  test('Usecase [UPDATE POST]', () async {
    ///[arranges]
    ///[right]
    when(updatePost.updatePost(post: post))
        .thenAnswer((realInvocation) async => const Right(unit));

    ///[left]
    when(updatePost.updatePost(post: post))
        .thenAnswer((realInvocation) async => Left(ServerFailure()));

    ///[acts]
    final result = await updatePost.updatePost(post: post);

    ///[expects]
    verify(updatePost.updatePost(post: post));
    verifyNoMoreInteractions(updatePost);

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
