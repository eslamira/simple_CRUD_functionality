import 'package:elrizk_task/ui/splash_screen.dart';
import 'package:elrizk_task/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elrizk company',
      theme: AppTheme().mainTheme,
      home: SplashScreen(),
    );
  }
}
