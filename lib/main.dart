import 'package:complaint_admin/dashboard.dart';
import 'package:complaint_admin/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'complaints_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is ready before initializing Firebase
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint App',
      theme: ThemeData(primarySwatch: Colors.cyan),
      //home: Dashboard(), // Replace with your ComplaintsPage
      home: LoginPage(),
    );
  }
}
