import 'package:flutter_test/flutter_test.dart';

import 'package:poseme/main.dart';

void main() {
  testWidgets('Home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const PoseMeApp());

    expect(find.text('PoseMe'), findsOneWidget);
    expect(find.text('you mean it.'), findsOneWidget);
    expect(find.text('Find My Pose'), findsOneWidget);
    expect(find.text('Explore Poses'), findsOneWidget);
  });
}
