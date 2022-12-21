import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:unit_testing/core/injection/injection.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/presnetation/views/add_or_edit_post_screen.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await confirgureDependency();
  group('Test', () {
    testWidgets('[ADD POST]', (tester) async {
      ///[run widget for test]
      runWidgetForTesting(AddOrDeleteOrEditPostScreen());
      await tester.pumpAndSettle();

      ///[post]
      final textFiledTitle = find.byKey(const Key('post-title'));
      expect(textFiledTitle, findsOneWidget);
      await tester.enterText(textFiledTitle, 'test');
      await tester.pumpAndSettle();

      final textFiledBody = find.byKey(const Key('post-body'));
      expect(textFiledBody, findsOneWidget);
      await tester.enterText(textFiledBody, 'welcome in test');
      await tester.pump(const Duration(seconds: 3));

      final submitButton = find.text('Submit');
      final loaderIsWork = find.byKey(const Key('add-post-loader'));

      expect(loaderIsWork, findsNothing);
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);
      await tester.pump();

      expect(submitButton, findsNothing);
      expect(loaderIsWork, findsOneWidget);

      ///[waiting for changes]
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('[ADD EDIT]', (tester) async {
      ///[run widget for test]
      runWidgetForTesting(AddOrDeleteOrEditPostScreen(
        post: const Post(body: 'body data', title: 'title data'),
      ));
      await tester.pumpAndSettle();

      ///[post]
      final textFiledTitle = find.byKey(const Key('post-title'));
      final textFiledBody = find.byKey(const Key('post-body'));

      expect(textFiledTitle, findsOneWidget);
      expect(textFiledBody, findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('title data'), findsOneWidget);
      expect(find.text('body data'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));

      final submitButton = find.text('Submit');
      final loaderIsWork = find.byKey(const Key('add-post-loader'));

      expect(loaderIsWork, findsNothing);
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);
      await tester.pump();

      expect(submitButton, findsNothing);
      expect(loaderIsWork, findsOneWidget);

      ///[waiting for changes]
      await tester.pump(const Duration(seconds: 5));
    });
  });
}

runWidgetForTesting(Widget child) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: child,
    ),
  );
}
