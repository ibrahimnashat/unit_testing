import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/core/web_services/web_services.dart';

import 'web_services_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<WebServices>(),
  MockSpec<RequestOptions>(),
  MockSpec<Dio>(),
])
void main() {
  ///[testables]
  late WebServices webServices;
  late Dio dio;
  const base = 'https://jsonplaceholder.typicode.com';
  late Map<String, dynamic> firstPost;

  ///[setups]
  setUp(() async {
    webServices = MockWebServices();
    dio = MockDio();
    firstPost = await FixtrueReader().data(name: 'post_json');
  });

  ///[tests]
  group('Web Services', () {
    test('[GET]', () async {
      ///[arranges]
      when(dio.get('$base/posts/1')).thenAnswer((realInvocation) async =>
          Response(requestOptions: MockRequestOptions(), data: firstPost));

      ///[act]
      final dioGetResult = await dio.get('$base/posts/1');

      ///[expects]
      verify(dio.get('$base/posts/1'));
      verifyNoMoreInteractions(dio);
      expect(dioGetResult.data, firstPost);

      ///[test web services with same real data returen by dio get]
      when(webServices.geet(endPoint: '/posts/1')).thenAnswer(
          (realInvocation) async => Params(data: firstPost, status: 200));

      ///[act of web service GET]
      final webServiceGetResult = await webServices.geet(endPoint: '/posts/1');

      ///[verify web services GET and Dio GET]
      verify(webServices.geet(endPoint: '/posts/1'));
      verifyNoMoreInteractions(webServices);

      ///[verify web service GET result and Dio GET result]
      expect(dioGetResult.data, webServiceGetResult.data);
    });

    test('[Post]', () async {
      ///[arranges]
      when(dio.post('$base/posts/', data: firstPost)).thenAnswer(
          (realInvocation) async =>
              Response(requestOptions: MockRequestOptions(), data: firstPost));

      ///[act]
      final dioPostResult = await dio.post('$base/posts/', data: firstPost);

      ///[expects]
      verify(dio.post('$base/posts/', data: firstPost));
      verifyNoMoreInteractions(dio);
      expect(dioPostResult.data, firstPost);

      ///[test web service POST and dio POST]
      when(webServices.post(endPoint: '/posts/', body: firstPost)).thenAnswer(
          (realInvocation) async => Params(data: firstPost, status: 200));

      ///[act of web service POST]
      final webServicePostResult =
          await webServices.post(endPoint: '/posts/', body: firstPost);

      ///[verify web services POST and Dio POST]
      verify(webServices.post(endPoint: '/posts/', body: firstPost));
      verifyNoMoreInteractions(webServices);

      ///[verify web service POST result and Dio POST result]
      expect(dioPostResult.data, webServicePostResult.data);
    });

    test('[PUT]', () async {
      ///[arranges]
      when(dio.put('$base/posts/1', data: firstPost)).thenAnswer(
          (realInvocation) async =>
              Response(requestOptions: MockRequestOptions(), data: firstPost));

      ///[act]
      final dioPutResult = await dio.put('$base/posts/1', data: firstPost);

      ///[expects]
      verify(dio.put('$base/posts/1', data: firstPost));
      verifyNoMoreInteractions(dio);
      expect(dioPutResult.data, firstPost);

      ///[test web service PUT and dio PUT]
      when(webServices.put(endPoint: '/posts/1', body: firstPost)).thenAnswer(
          (realInvocation) async => Params(data: firstPost, status: 200));

      ///[act of web service PUT]
      final webServicePutResult =
          await webServices.put(endPoint: '/posts/1', body: firstPost);

      ///[verify web services PUT and Dio PUT]
      verify(webServices.put(endPoint: '/posts/1', body: firstPost));
      verifyNoMoreInteractions(webServices);

      ///[verify web service PUT result and Dio PUT result]
      expect(dioPutResult.data, webServicePutResult.data);
    });

    test('[DELETE]', () async {
      ///[arranges]
      when(dio.delete('$base/posts/1', data: firstPost)).thenAnswer(
          (realInvocation) async =>
              Response(requestOptions: MockRequestOptions(), data: firstPost));

      ///[act]
      final dioDeleteResult =
          await dio.delete('$base/posts/1', data: firstPost);

      ///[expects]
      verify(dio.delete('$base/posts/1', data: firstPost));
      verifyNoMoreInteractions(dio);
      expect(dioDeleteResult.data, firstPost);

      ///[test web service DELETE and dio DELETE]
      when(webServices.delete(endPoint: '/posts/1')).thenAnswer(
          (realInvocation) async => Params(data: firstPost, status: 200));

      ///[act of web service DELETE]
      final webServiceDeleteResult =
          await webServices.delete(endPoint: '/posts/1');

      ///[verify web services DELETE and Dio DELETE]
      verify(webServices.delete(endPoint: '/posts/1'));
      verifyNoMoreInteractions(webServices);

      ///[verify web service DELETE result and Dio DELETE result]
      expect(dioDeleteResult.data, webServiceDeleteResult.data);
    });
  });
}
