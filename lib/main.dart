import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'drive_list_page.dart';

void main() {
  runApp(const MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shadowColor: Colors.white70,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      ),
      highContrastTheme: ThemeData(),
      highContrastDarkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const DriveList(), //const DriveList(),
    );
  }
}
