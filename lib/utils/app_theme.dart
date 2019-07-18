import 'package:flutter/material.dart';

class AppTheme {
  ThemeData mainTheme = ThemeData(
    primaryColor: Colors.black,
    accentColor: Colors.redAccent,
    unselectedWidgetColor: Color(0xFFEDC7B6),
    scaffoldBackgroundColor: Colors.black,
    indicatorColor: Color(0xFFF76D6D),
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w300,
      ),
      subtitle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      subhead: TextStyle(
        color: Color(0xFFDA483F),
      ),
      button: TextStyle(
        color: Color(0xFFDA483F),
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
        color: Color(0xFFF64C4C),
        fontSize: 16,
        fontFamily: "Arial",
        fontWeight: FontWeight.w300,
      ),
      headline: TextStyle(
        color: Color(0xFFF76D6D),
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    ),

    // --- Theming App Bars --- //
    appBarTheme: AppBarTheme(
      color: Color(0xFFF64C4C), // background color for app bar
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
        color: Color(0xFFEDC7B6),
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 18,
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
        color: Color(0xFF434343),
        fontSize: 16,
      ),
      display2: TextStyle(
        color: Color(0xFFF64C4C),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      display3: TextStyle(
        color: Color(0xFFF64C4C),
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
    // -- Divider -- //
    dividerColor: Color(0xFFF76D6D),

    //-- Buttons --//
    buttonColor: Color(0xFFF76D6D),

    //-- Splash Color ex: in InkWell --//
    splashColor: Color(0xFFF76D6D),
  );
}
