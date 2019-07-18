import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hi, Welcome to my App',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
