import 'package:flutter_test/flutter_test.dart';
import 'package:its_handbook/main.dart' as app;

void main() {
  testWidgets('App starts and shows Sign in', (WidgetTester tester) async {
    await tester.pumpWidget(const app.MainApp());
    await tester.pumpAndSettle();

    // We expect the sign-in text to be present (may appear multiple times: app bar and button)
    expect(find.text('Sign in'), findsWidgets);
  });
}
