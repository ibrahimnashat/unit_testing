import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/exceptions.dart';
import 'package:unit_testing/core/framework/network.dart';
import 'package:unit_testing/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:unit_testing/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart';

@LazySingleton(as: PostsRepositroy)
class PostsRepositoryImpl extends PostsRepositroy {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final Network network;

  PostsRepositoryImpl({
    required this.localDataSource,
    required this.network,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addPost({required Post post}) async {
    return await deleteOrEditOrUpdate(request: () async {
      return await remoteDataSource.addPost(
        post: PostModel(
          body: post.body,
          id: post.id,
          title: post.title,
          userId: 1,
        ),
      );
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await network.isConnected) {
      try {
        final res = await remoteDataSource.getPosts();
        await localDataSource.cachingPosts(posts: res);
        return Right(res);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final res = await localDataSource.getPosts();
        return Right(res);
      } on CachingException {
        return Left(CachedFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    return await deleteOrEditOrUpdate(request: () async {
      final res = await remoteDataSource.updatePost(
        post: PostModel(
          body: post.body,
          id: post.id,
          title: post.title,
          userId: 1,
        ),
      );
      return res;
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    return await deleteOrEditOrUpdate(request: () async {
      return await remoteDataSource.deletePost(postId: postId);
    });
  }

  Future<Either<Failure, Unit>> deleteOrEditOrUpdate({
    required Function request,
  }) async {
    if (await network.isConnected) {
      try {
        final res = await request();

        return Right(res);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    return Left(ServerFailure());
  }
}
