import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/exceptions.dart';
import 'package:unit_testing/core/web_services/web_services.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<Unit> addPost({required PostModel post});
  Future<List<PostModel>> getPosts();
  Future<Unit> updatePost({required PostModel post});
  Future<Unit> deletePost({required int postId});
}

@LazySingleton(as: PostsRemoteDataSource)
class PostsRemoteDataSourceImpl extends PostsRemoteDataSource {
  final WebServices webServices;

  PostsRemoteDataSourceImpl({required this.webServices});

  @override
  Future<Unit> addPost({required PostModel post}) async {
    return await getPostsOrDeleteOrEditOrUpdate<Unit>(request: () async {
      log(post.toJson().toString());
      final res =
          await webServices.post(endPoint: '/posts', body: post.toJson());

      if (res.status == 200 || res.status == 201) {
        return unit;
      }
    });
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final postsJson =
        await getPostsOrDeleteOrEditOrUpdate<List>(request: () async {
      final res = await webServices.geet(endPoint: '/posts');

      if (res.status == 200 || res.status == 201) {
        return res.data;
      }
    });
    return postsJson.map((e) => PostModel.fromJson(e)).toList();
  }

  @override
  Future<Unit> updatePost({required PostModel post}) async {
    return await getPostsOrDeleteOrEditOrUpdate<Unit>(request: () async {
      final res = await webServices.put(
        endPoint: '/posts/${post.id}',
        body: post.toJson(),
      );
      if (res.status == 200 || res.status == 201) {
        return unit;
      }
    });
  }

  @override
  Future<Unit> deletePost({required int postId}) async {
    return await getPostsOrDeleteOrEditOrUpdate<Unit>(request: () async {
      final res = await webServices.delete(endPoint: '/posts/$postId');
      if (res.status == 200 || res.status == 201) {
        return unit;
      }
    });
  }

  Future<T> getPostsOrDeleteOrEditOrUpdate<T>({
    required Function request,
  }) async {
    try {
      T res = await request();
      if (res != null) {
        return res;
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
