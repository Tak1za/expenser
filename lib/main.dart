import 'package:expenser/pages/home_page.dart';
import 'package:expenser/provider/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './themes/themes.dart' as t;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: t.Theme.light(),
        darkTheme: t.Theme.dark(),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
