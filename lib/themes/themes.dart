import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Theme {
  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.deepPurple[200],
        primaryContainer: const Color(0x003700B3),
        secondary: Colors.teal[200],
        background: Colors.black,
        surface: Colors.teal[900],
        error: const Color(0x00CF6679),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onBackground: Colors.white,
        onSurface: Colors.white,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.teal[900]),
        ),
      ),
      useMaterial3: true,
      splashColor: Colors.deepPurple[200],
      textTheme: TextTheme(
        labelLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        labelMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        labelSmall: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        headlineLarge: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontFamily: "Exo",
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Exo",
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: "Exo",
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: const TextStyle(
          color: Colors.grey,
          fontSize: 30,
        ),
        bodyMedium: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
        bodySmall: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        titleLarge: TextStyle(
          fontSize: 30,
          color: Colors.deepPurple[200],
          fontFamily: "Exo",
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          color: Colors.deepPurple[200],
          fontFamily: "Exo",
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          color: Colors.deepPurple[200],
          fontFamily: "Exo",
        ),
      ),
      scaffoldBackgroundColor: const Color(0x00121212),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        color: Colors.black,
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
    );
  }
}
