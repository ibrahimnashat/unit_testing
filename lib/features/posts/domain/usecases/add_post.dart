import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart';

@lazySingleton
class AddPost {
  final PostsRepositroy postsRepositroy;

  AddPost({required this.postsRepositroy});

  Future<Either<Failure, Unit>> addPost({required Post post}) async {
    return postsRepositroy.addPost(post: post);
  }
}
