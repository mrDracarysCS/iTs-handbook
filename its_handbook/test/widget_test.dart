import 'package:flutter_test/flutter_test.dart';
import 'package:its_handbook/main.dart' as app;

void main() {
  testWidgets('App starts and shows Sign in', (WidgetTester tester) async {
    await tester.pumpWidget(const app.MainApp());
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsOneWidget);
  });
}
