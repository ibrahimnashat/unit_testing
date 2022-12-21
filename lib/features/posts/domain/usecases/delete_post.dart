import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart';

@lazySingleton
class DeletePost {
  final PostsRepositroy postsRepositroy;

  DeletePost({required this.postsRepositroy});

  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    return postsRepositroy.deletePost(postId: postId);
  }
}
