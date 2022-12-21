import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/get_posts.dart';

import 'get_posts_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetPosts>(),
])
void main() {
  ///[testables]
  late GetPosts getPosts;
  late Post post;

  ///[setups]
  setUp(() async {
    getPosts = MockGetPosts();
    final json = await FixtrueReader().data(name: 'post_json');
    post = PostModel.fromJson(json);
  });

  ///[tests]
  test('Usecase [GET POSTS]', () async {
    ///[arranges]
    ///[right]
    when(getPosts.getPosts())
        .thenAnswer((realInvocation) async => Right([post]));

    ///[left]
    when(getPosts.getPosts())
        .thenAnswer((realInvocation) async => Left(ServerFailure()));

    ///[acts]
    final result = await getPosts.getPosts();

    ///[expects]
    verify(getPosts.getPosts());
    verifyNoMoreInteractions(getPosts);

    result.fold(
      (failure) {
        ///[left]
        expect(failure, isA<ServerFailure>());
      },
      (response) {
        ///[right]
        expect([post], response);
        expect(post, equals(response.first));
      },
    );
  });
}
