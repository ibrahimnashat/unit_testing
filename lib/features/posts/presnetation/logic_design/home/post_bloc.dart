// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/delete_post.dart';
import 'package:unit_testing/features/posts/domain/usecases/get_posts.dart';

part 'post_event.dart';
part 'post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;
  final DeletePost deletePosts;
  PostBloc({
    required this.getPosts,
    required this.deletePosts,
  }) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is PostsLoading) {
        emit(PostsIsLoading());
        final postsOrFailure = await getPosts.getPosts();
        postsOrFailure.fold(
          (failure) {
            emit(PostsError());
          },
          (posts) {
            emit(PostsLoaded(posts: posts));
          },
        );
      }
    });
  }

  Future<void> deletePost({required Post post}) async {
    final deleteOrFailure = await deletePosts.deletePost(postId: post.id!);
    deleteOrFailure.fold(
      (failure) {
        emit(PostsError());
      },
      (unit) {
        add(PostsLoading());
      },
    );
  }
}
