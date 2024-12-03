import 'package:flutter/material.dart';
import 'package:vehical_app/pages/vehical/vehical_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер водителей',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const VehicalPage(),
    );
  }
}
