import 'package:flutter_test/flutter_test.dart';
import 'package:amir_portfolio/app.dart';

void main() {
  testWidgets('Portfolio app renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    // App should mount without throwing
    expect(find.byType(App), findsOneWidget);
  });
}
