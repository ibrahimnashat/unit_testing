import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart';

@lazySingleton
class UpdatePost {
  final PostsRepositroy postsRepositroy;

  UpdatePost({required this.postsRepositroy});

  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    return postsRepositroy.updatePost(post: post);
  }
}
