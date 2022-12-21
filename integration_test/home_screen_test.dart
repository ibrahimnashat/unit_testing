import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:unit_testing/core/injection/injection.dart';
import 'package:unit_testing/features/posts/presnetation/views/home_screen.dart';
import 'package:unit_testing/features/posts/presnetation/widgets/post_item.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await confirgureDependency();
  group('Test', () {
    testWidgets('[HOME SCREEN]', (tester) async {
      ///[run widget for test]
      runWidgetForTesting(const HomeScreen());
      await tester.pumpAndSettle();

      ///[home screen]

      expect(find.text('Posts'), findsOneWidget);
      expect(find.byType(PostItem), findsWidgets);

      ///[tap on add post button]
      await tester.pump(const Duration(seconds: 2));
      final addPostButton = find.byIcon(Icons.add);
      expect(addPostButton, findsOneWidget);
      await tester.tap(addPostButton);

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
