import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hype49sneakers/main.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(CupertinoApp), findsOneWidget);
  });
}