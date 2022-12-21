// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_checker/connectivity_checker.dart' as _i3;
import 'package:dio/dio.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;
import 'package:unit_testing/core/framework/network.dart' as _i5;
import 'package:unit_testing/core/injection/injection.dart' as _i19;
import 'package:unit_testing/core/web_services/web_services.dart' as _i8;
import 'package:unit_testing/features/posts/data/data_sources/posts_local_data_source.dart'
    as _i9;
import 'package:unit_testing/features/posts/data/data_sources/posts_remote_data_source.dart'
    as _i10;
import 'package:unit_testing/features/posts/data/repository/posts_repository_impl.dart'
    as _i12;
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart'
    as _i11;
import 'package:unit_testing/features/posts/domain/usecases/add_post.dart'
    as _i14;
import 'package:unit_testing/features/posts/domain/usecases/delete_post.dart'
    as _i15;
import 'package:unit_testing/features/posts/domain/usecases/get_posts.dart'
    as _i16;
import 'package:unit_testing/features/posts/domain/usecases/update_post.dart'
    as _i13;
import 'package:unit_testing/features/posts/presnetation/logic_design/add_or_edit_post/add_or_edit_post_bloc.dart'
    as _i18;
import 'package:unit_testing/features/posts/presnetation/logic_design/home/post_bloc.dart'
    as _i17;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.factory<_i3.ConnectivityWrapper>(
        () => injectionModule.connectivityWrapper);
    gh.factory<_i4.Dio>(() => injectionModule.dio);
    gh.factory<_i5.Network>(() =>
        _i5.NetworkStatus(connectivityWrapper: gh<_i3.ConnectivityWrapper>()));
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i7.TextEditingController>(
        () => injectionModule.textEditingController);
    gh.lazySingleton<_i8.WebServices>(
        () => _i8.WebServicesImp(dio: gh<_i4.Dio>()));
    gh.lazySingleton<_i9.PostsLocalDataSource>(() =>
        _i9.PostsLocalDataSourceImpl(
            sharedPreferences: gh<_i6.SharedPreferences>()));
    gh.lazySingleton<_i10.PostsRemoteDataSource>(() =>
        _i10.PostsRemoteDataSourceImpl(webServices: gh<_i8.WebServices>()));
    gh.lazySingleton<_i11.PostsRepositroy>(() => _i12.PostsRepositoryImpl(
          localDataSource: gh<_i9.PostsLocalDataSource>(),
          network: gh<_i5.Network>(),
          remoteDataSource: gh<_i10.PostsRemoteDataSource>(),
        ));
    gh.lazySingleton<_i13.UpdatePost>(
        () => _i13.UpdatePost(postsRepositroy: gh<_i11.PostsRepositroy>()));
    gh.lazySingleton<_i14.AddPost>(
        () => _i14.AddPost(postsRepositroy: gh<_i11.PostsRepositroy>()));
    gh.lazySingleton<_i15.DeletePost>(
        () => _i15.DeletePost(postsRepositroy: gh<_i11.PostsRepositroy>()));
    gh.lazySingleton<_i16.GetPosts>(
        () => _i16.GetPosts(postsRepositroy: gh<_i11.PostsRepositroy>()));
    gh.factory<_i17.PostBloc>(() => _i17.PostBloc(
          getPosts: gh<_i16.GetPosts>(),
          deletePosts: gh<_i15.DeletePost>(),
        ));
    gh.factory<_i18.AddOrEditPostBloc>(() => _i18.AddOrEditPostBloc(
          addPosts: gh<_i14.AddPost>(),
          updatePosts: gh<_i13.UpdatePost>(),
          bodyController: gh<_i7.TextEditingController>(),
          titleController: gh<_i7.TextEditingController>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i19.InjectionModule {}
