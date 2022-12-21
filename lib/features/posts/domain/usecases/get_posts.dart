import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart';

@lazySingleton
class GetPosts {
  final PostsRepositroy postsRepositroy;

  GetPosts({required this.postsRepositroy});

  Future<Either<Failure, List<Post>>> getPosts() async {
    return postsRepositroy.getPosts();
  }
}
