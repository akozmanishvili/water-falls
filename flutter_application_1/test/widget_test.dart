// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/services.dart';
import 'package:flutter_application_1/widgets/modified_snake.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App loads with buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    //await tester.tap(find.byIcon(Icons.add));

    expect(find.byType(ElevatedButton), findsNWidgets(3));
  });

  testWidgets('New Game loads NewGame screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key('New Game')));
    await tester.pumpAndSettle();
    //removed newgame!
  });

  testWidgets('About Project loads NewGame screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key('About the Project')));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);
  });

  testWidgets('How To Play loads HowToScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key('How To Play')));
    await tester.pumpAndSettle();

    expect(find.byType(HowToScreen), findsOneWidget);
  });

  testWidgets('About Project allows return to Main Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key('About the Project')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('Main Menu')));
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);
  });

  testWidgets('How To Play allows return to Main Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key('How To Play')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('Main Menu')));
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);
  });

  testWidgets('New Game allows return to Main Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key('New Game')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('Main Menu')));
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);
  });
  testWidgets('Dragging across the grid places water along the path', (
    WidgetTester tester,
  ) async {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    for (final name in [
      'dev.fluttercommunity.plus/sensors/method',
      'dev.fluttercommunity.plus/sensors/accelerometer',
    ]) {
      messenger.setMockMethodCallHandler(
        MethodChannel(name),
        (call) async => null,
      );
    }

    // 20x20 grid, 10px per cell
    final grid = Snake(rows: 20, columns: 20, cellSize: 10);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(alignment: Alignment.topLeft, child: grid),
        ),
      ),
    );

    // drag from cell (3,10) to cell (17,10)
    await tester.dragFrom(const Offset(30, 100), const Offset(140, 0));
    await tester.pump();

    final fluid = grid.state.fluid;
    expect(fluid.m[fluid.index(3, 10)], greaterThan(0));
    expect(fluid.m[fluid.index(16, 10)], greaterThan(0));
  });
}
