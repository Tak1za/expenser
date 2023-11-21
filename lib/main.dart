import 'package:expenser/pages/home_page.dart';
import 'package:flutter/material.dart';
import './themes/themes.dart' as t;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: t.Theme.light(),
      darkTheme: t.Theme.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
