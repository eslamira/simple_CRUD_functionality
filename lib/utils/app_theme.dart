import 'package:flutter/material.dart';

class AppTheme {
  ThemeData mainTheme = ThemeData(
    primaryColor: Colors.deepPurple,
    accentColor: Colors.deepPurple[700],
    unselectedWidgetColor: Colors.deepPurple[100],
    scaffoldBackgroundColor: Colors.deepPurpleAccent,
    indicatorColor: Colors.deepPurple,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w300,
      ),
      subtitle: TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
      subhead: TextStyle(
        color: Colors.black,
      ),
      button: TextStyle(
        color: Colors.white,
      ),
      overline: TextStyle(
        color: Color(0xFF515C6F),
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      caption: TextStyle(
        color: Color(0xFF29658A),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      display1: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      display2: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      display3: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: "Arial",
        fontWeight: FontWeight.bold,
      ),
      display4: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      body1: TextStyle(
        color: Color(0xFF85AEDD),
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
      body2: TextStyle(
        color: Colors.deepPurple,
        fontSize: 16,
        fontFamily: "Arial",
        fontWeight: FontWeight.w300,
      ),
      headline: TextStyle(
        color: Colors.deepPurple[400],
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    ),

    // --- Theming App Bars --- //
    appBarTheme: AppBarTheme(
      color: Colors.deepPurple, // background color for app bar
      brightness: Brightness.dark, // this controls the status bar text color

      // --- Theming Texts in Appbar ex: Title --- //
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white, // Text Color
          fontSize: 22, // Font Size
          fontWeight: FontWeight.bold, // Font Weight
        ),
        subtitle: TextStyle(
          color: Colors.black, // Text Color
          fontSize: 20, // Font Size
          fontWeight: FontWeight.bold, // Font Weight
        ),
      ),

      // -- Theming App Bar Icons -- //
      iconTheme: IconThemeData(
        color: Colors.white, // Icon Color
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),

    // --- Theming Other Stuff --- //
    inputDecorationTheme: InputDecorationTheme(
      // hidden counter yay!!
      counterStyle: TextStyle(
        fontSize: 0,
        height: 0,
      ),
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: Colors.deepPurple[100],
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 12,
      ),
    ),

    primaryTextTheme: TextTheme(
      title: TextStyle(
        fontFamily: 'Ariel',
        color: Color(0xFF434343),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      display1: TextStyle(
        fontFamily: 'Ariel',
        color: Colors.white,
        fontSize: 16,
      ),
      display2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      display3: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.lineThrough,
        fontSize: 16,
      ),
      body1: TextStyle(
        // See more texts
        color: Color(0xFF85AEDD),
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
    ),

    //-- Buttons --//
    buttonColor: Colors.deepPurple[700],

    //-- Splash Color ex: in InkWell --//
    splashColor: Colors.deepPurple,
  );
}
