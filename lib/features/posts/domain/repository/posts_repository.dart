import 'package:dartz/dartz.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';

abstract class PostsRepositroy {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Unit>> updatePost({required Post post});
  Future<Either<Failure, Unit>> deletePost({required int postId});
  Future<Either<Failure, Unit>> addPost({required Post post});
}
