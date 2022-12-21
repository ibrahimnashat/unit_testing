import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> confirgureDependency() async {
  await getIt.init(environment: 'dev');
}

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @injectable
  Dio get dio => Dio();
  @injectable
  ConnectivityWrapper get connectivityWrapper => ConnectivityWrapper.instance;
  @injectable
  TextEditingController get textEditingController => TextEditingController();
}
