import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:global_state/global_state.dart';
import 'package:global_state_application/main.dart';

void main() {
  testWidgets('Add and increment counter', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GlobalState(),
        child: MaterialApp(home: MyGlobalCounterApp()),
      ),
    );

    // Initially no counters
    expect(find.text('0'), findsNothing);

    // Tap FAB to add a counter
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Counter 1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tap '+' icon to increment
    await tester.tap(find.widgetWithIcon(IconButton, Icons.add).first);
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
