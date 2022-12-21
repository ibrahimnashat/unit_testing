import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';

import 'posts_local_data_source_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<PostsLocalDataSource>(), MockSpec<SharedPreferences>()])
void main() {
  ///[testables]
  late PostsLocalDataSource localDataSource;
  late SharedPreferences sharedPreferences;
  late List<PostModel> posts;
  late String stringOfPosts;

  ///[setups]
  setUp(() async {
    localDataSource = MockPostsLocalDataSource();
    sharedPreferences = MockSharedPreferences();
    final post = await FixtrueReader().data(name: 'post_json');
    stringOfPosts = json.encode([post]);
    posts = [PostModel.fromJson(post)];
  });

  ///[tests]
  group('Local data source', () {
    test('[CACHING]', () async {
      ///[arranges]
      when(sharedPreferences.setString(CACHED_POSTS, stringOfPosts))
          .thenAnswer((realInvocation) async => true);

      ///[act]
      final resultOfSharedPrefrences =
          await sharedPreferences.setString(CACHED_POSTS, stringOfPosts);

      ///[expects]
      verify(sharedPreferences.setString(CACHED_POSTS, stringOfPosts));
      verifyNoMoreInteractions(sharedPreferences);
      expect(resultOfSharedPrefrences, true);

      ///[test local data source for the result of sharedprefrences]
      when(localDataSource.cachingPosts(posts: posts))
          .thenAnswer((realInvocation) async => true);

      ///[act]
      final localDataSourceResult =
          await localDataSource.cachingPosts(posts: posts);

      ///[expects]
      verify(localDataSource.cachingPosts(posts: posts));
      verifyNoMoreInteractions(localDataSource);

      ///[final test for sharedprefrences and local datasource]
      expect(resultOfSharedPrefrences, localDataSourceResult);
    });
    test('[GET CACHED]', () async {
      ///[arranges]
      when(sharedPreferences.getString(CACHED_POSTS))
          .thenAnswer((realInvocation) => stringOfPosts);

      ///[act]
      final resultOfSharedPrefrences =
          sharedPreferences.getString(CACHED_POSTS);

      ///[expects]
      verify(sharedPreferences.getString(CACHED_POSTS));
      verifyNoMoreInteractions(sharedPreferences);
      expect(resultOfSharedPrefrences, stringOfPosts);

      ///[test local data source for the result of sharedprefrences]
      when(localDataSource.getPosts())
          .thenAnswer((realInvocation) async => posts);

      ///[act]
      final localDataSourceResult = await localDataSource.getPosts();

      ///[expects]
      verify(localDataSource.getPosts());
      verifyNoMoreInteractions(localDataSource);

      ///[final test for sharedprefrences and local datasource]
      expect(resultOfSharedPrefrences,
          json.encode(localDataSourceResult.map((e) => e.toJson()).toList()));
    });
  });
}
