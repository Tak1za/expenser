import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Theme {
  static ThemeData dark() {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffcfbcff),
        onPrimary: Color(0xff22005d),
        primaryContainer: Color(0xff503298),
        onPrimaryContainer: Color(0xffe9ddff),
        secondary: Color(0xffe9ddff),
        onSecondary: Color(0xff210b4e),
        secondaryContainer: Color(0xff372464),
        onSecondaryContainer: Color(0xffe9ddff),
        tertiary: Color(0xffffb0ca),
        onTertiary: Color(0xff3c031e),
        tertiaryContainer: Color(0xff73304a),
        onTertiaryContainer: Color(0xffffd9e3),
        error: Color(0xffffb4ab),
        onError: Color(0xff410002),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xffffb4ab),
        background: Color(0xff1e1c21),
        onBackground: Color(0xffe6e0e9),
        surface: Color(0xff1d1b20),
        onSurface: Color(0xffe6e0e9),
        surfaceVariant: Color(0xff494551),
        onSurfaceVariant: Color(0xffcbc4d2),
        outline: Color(0xff948e9c),
        outlineVariant: Color(0xff494551),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffe5dfe9),
        onInverseSurface: Color(0xff322f35),
        inversePrimary: Color(0xff684cb2),
        surfaceTint: Color(0xffcfbcff),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xFF263238)),
        ),
      ),
      useMaterial3: true,
      splashColor: Colors.purple[200],
      textTheme: const TextTheme(
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Colors.grey,
        ),
        bodyMedium: TextStyle(
          color: Colors.grey,
        ),
        bodySmall: TextStyle(
          color: Colors.grey,
        ),
      ),
      scaffoldBackgroundColor: const Color(0x00121212),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        color: Colors.black,
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff6750a4),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffe9ddff),
        onPrimaryContainer: Color(0xff22005d),
        secondary: Color(0xff7f6cb0),
        onSecondary: Color(0xfffffbff),
        secondaryContainer: Color(0xfff6edff),
        onSecondaryContainer: Color(0xff210b4e),
        tertiary: Color(0xff904762),
        onTertiary: Color(0xfffffbff),
        tertiaryContainer: Color(0xffffd9e3),
        onTertiaryContainer: Color(0xff3c031e),
        error: Color(0xffba1a1a),
        onError: Color(0xfffffbff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        background: Color(0xfffefafe),
        onBackground: Color(0xff1d1b20),
        surface: Color(0xfffffbff),
        onSurface: Color(0xff1d1b20),
        surfaceVariant: Color(0xffe7e0ef),
        onSurfaceVariant: Color(0xff494551),
        outline: Color(0xff7a7582),
        outlineVariant: Color(0xffcbc4d2),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff322f35),
        onInverseSurface: Color(0xfff5eff7),
        inversePrimary: Color(0xffcfbcff),
        surfaceTint: Color(0xff503298),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xFF263238)),
        ),
      ),
      useMaterial3: true,
      splashColor: Colors.purple[200],
      textTheme: const TextTheme(
        labelLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Colors.grey,
        ),
        bodyMedium: TextStyle(
          color: Colors.grey,
        ),
        bodySmall: TextStyle(
          color: Colors.grey,
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        color: Colors.black,
      ),
    );
  }
}
