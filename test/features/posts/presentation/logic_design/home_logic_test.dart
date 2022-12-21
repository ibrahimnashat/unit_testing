import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/delete_post.dart';
import 'package:unit_testing/features/posts/domain/usecases/get_posts.dart';
import 'package:unit_testing/features/posts/presnetation/logic_design/home/post_bloc.dart';

import 'home_logic_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetPosts>(),
  MockSpec<DeletePost>(),
])
void main() {
  ///[tests]
  late Post post;
  late PostBloc postBloc;
  late DeletePost deletePost;
  late GetPosts getPosts;

  ///[setups]
  setUp(() async {
    final json = await FixtrueReader().data(name: 'post_json');
    post = PostModel.fromJson(json);
    deletePost = MockDeletePost();
    getPosts = MockGetPosts();
    postBloc = PostBloc(deletePosts: deletePost, getPosts: getPosts);
  });
  group('Post bloc', () {
    blocTest<PostBloc, PostState>(
      '[LOADING AND LOADED STATES]',
      build: () {
        when(getPosts.getPosts())
            .thenAnswer((realInvocation) async => Right([post]));
        return postBloc;
      },
      act: (bloc) {
        bloc.add(PostsLoading());
      },
      wait: const Duration(seconds: 2),
      expect: () => <PostState>[
        PostsIsLoading(),
        PostsLoaded(posts: [post]),
      ],
    );

    blocTest<PostBloc, PostState>(
      '[DELETE POST]',
      build: () {
        when(getPosts.getPosts())
            .thenAnswer((realInvocation) async => Right([post]));
        when(deletePost.deletePost(postId: post.id!))
            .thenAnswer((realInvocation) async => const Right(unit));
        return postBloc;
      },
      act: (bloc) {
        bloc.deletePost(post: post);
      },
      expect: () => <PostState>[
        PostsIsLoading(),
        PostsLoaded(posts: [post])
      ],
    );
  });
}
