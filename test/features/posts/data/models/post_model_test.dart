import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/fixtures/fixture.dart';
import 'package:unit_testing/features/posts/data/models/post_model.dart';

import 'post_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostModel>()])
void main() {
  ///[testabes]
  late PostModel post;
  late Map<String, dynamic> json;

  ///[setups]
  setUp(() async {
    post = MockPostModel();
    json = await FixtrueReader().data(name: 'post_json');
  });

  ///[tests]
  group('Post Model', () {
    test('[TOJSON]', () {
      ///[arranges]
      when(post.toJson()).thenAnswer((realInvocation) => <String, dynamic>{});

      ///[acts]
      final result = post.toJson();

      ///[expects]
      verify(post.toJson());
      verifyNoMoreInteractions(post);
      expect(result, isA<Map<String, dynamic>>());
    });
    test('[FROMJSON]', () {
      ///[acts]
      final result = PostModel.fromJson(json);

      ///[expects]
      expect(result, isA<PostModel>());
    });
  });
}
