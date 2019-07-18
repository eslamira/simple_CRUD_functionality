import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Hi and Welcome to my very simple app\n\n\n'
                'This is a simple app provides a simple CRUD functions using firebase RESTful API.'
                '\n\nThis App is just a prove of concept.'
                '\n\nFeel free to check and try everything in it.',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
