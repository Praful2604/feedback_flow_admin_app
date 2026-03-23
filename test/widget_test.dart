import 'package:complaint_admin/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complaint_admin/main.dart'; // Import the main.dart file to get access to MyApp

void main() {
  testWidgets('Login page test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the LoginPage is shown.
    expect(find.byType(LoginPage), findsOneWidget);  // Make sure LoginPage widget is present

    // If your LoginPage has any specific text, for example, a button or title, test it.
    // Replace 'Login' with the actual text widget if you have one in LoginPage.
    expect(find.text('Login'), findsOneWidget);  // Example text to verify the page

    // You can test interactions, for example, tapping a button if you have one.
    // await tester.tap(find.byType(ElevatedButton)); // If there's an ElevatedButton
    // await tester.pump(); // Rebuild the widget after the tap
  });
}
