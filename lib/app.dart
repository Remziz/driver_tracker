import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehical_app/auth_screens/login_screen.dart';
import 'package:vehical_app/auth_screens/splash_screen.dart';
import 'package:vehical_app/pages/vehical/vehical_page.dart';
import 'package:vehical_app/pages/vehical_add/vehical_add_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер водителей',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/splash_screen',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash_screen':
            return CupertinoPageRoute(builder: (_) => SplashScreen());
          case '/vehical_screen':
            return CupertinoPageRoute(builder: (_) => VehicalPage());
          case '/login_screen':
            return CupertinoPageRoute(builder: (_) => LoginScreen());
          case '/vehical_add':
            return CupertinoPageRoute(builder: (_) => VehicalAddScreen());
          default:
            return null;
        }
      },
    );
  }
}
