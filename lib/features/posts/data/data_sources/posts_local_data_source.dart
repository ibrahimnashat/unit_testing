import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unit_testing/core/errors/exceptions.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';

// ignore: constant_identifier_names
const CACHED_POSTS = 'CACHED_POSTS';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getPosts();
  Future<bool> cachingPosts({required List<PostModel> posts});
}

@LazySingleton(as: PostsLocalDataSource)
class PostsLocalDataSourceImpl extends PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<bool> cachingPosts({required List<PostModel> posts}) async {
    try {
      final res = await sharedPreferences.setString(
          CACHED_POSTS, json.encode(posts.map((e) => e.toJson()).toList()));
      return res;
    } catch (e) {
      throw CachingException();
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final postsString = sharedPreferences.getString(CACHED_POSTS);
      if (postsString != null) {
        List<dynamic> postJson = json.decode(postsString);
        List<PostModel> posts =
            postJson.map((e) => PostModel.fromJson(e)).toList();
        return posts;
      }
      throw CachingException();
    } catch (e) {
      throw CachingException();
    }
  }
}
