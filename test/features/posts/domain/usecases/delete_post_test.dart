import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/usecases/delete_post.dart';

import 'delete_post_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DeletePost>(),
])
void main() {
  ///[testables]
  late DeletePost deletePost;

  ///[setups]
  setUp(() async {
    deletePost = MockDeletePost();
  });

  ///[tests]
  test('Usecase [DELETE POST]', () async {
    ///[arranges]
    ///[right]
    when(deletePost.deletePost(postId: 1))
        .thenAnswer((realInvocation) async => const Right(unit));

    ///[left]
    when(deletePost.deletePost(postId: 1))
        .thenAnswer((realInvocation) async => Left(ServerFailure()));

    ///[acts]
    final result = await deletePost.deletePost(postId: 1);

    ///[expects]
    verify(deletePost.deletePost(postId: 1));
    verifyNoMoreInteractions(deletePost);

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
