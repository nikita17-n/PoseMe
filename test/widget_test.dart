import 'package:flutter_test/flutter_test.dart';

import 'package:poseme/main.dart';

void main() {
  testWidgets('Welcome screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const PoseMeApp());

    expect(find.text('Your Perfect Pose,'), findsOneWidget);
    expect(find.text('Every Time'), findsOneWidget);
    expect(find.text('Find your pose. Capture your moment.'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });
}
