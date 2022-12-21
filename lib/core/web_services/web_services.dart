// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class WebServices {
  Future<Params> geet({
    required String endPoint,
  });
  Future<Params> post({
    required String endPoint,
    required Map<String, dynamic> body,
  });
  Future<Params> delete({
    required String endPoint,
  });
  Future<Params> put({
    required String endPoint,
    required Map<String, dynamic> body,
  });
}

class Params {
  final int? status;
  final dynamic data;

  const Params({required this.data, required this.status});
}

const BaseUrl = 'https://jsonplaceholder.typicode.com';

@LazySingleton(as: WebServices)
class WebServicesImp extends WebServices {
  final Dio dio;

  WebServicesImp({required this.dio});

  @override
  Future<Params> geet({
    required String endPoint,
  }) async {
    final response = await dio.get(
      BaseUrl + endPoint,
      options: Options(contentType: 'application/json'),
    );
    return Params(
      data: response.data,
      status: response.statusCode,
    );
  }

  @override
  Future<Params> post({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    final response = await dio.post(
      BaseUrl + endPoint,
      data: body,
      options: Options(contentType: 'application/json'),
    );
    return Params(
      data: response.data,
      status: response.statusCode,
    );
  }

  @override
  Future<Params> delete({
    required String endPoint,
  }) async {
    final response = await dio.delete(
      BaseUrl + endPoint,
      options: Options(contentType: 'application/json'),
    );
    return Params(
      data: response.data,
      status: response.statusCode,
    );
  }

  @override
  Future<Params> put({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    final response = await dio.put(
      BaseUrl + endPoint,
      data: body,
      options: Options(contentType: 'application/json'),
    );
    return Params(
      data: response.data,
      status: response.statusCode,
    );
  }
}
