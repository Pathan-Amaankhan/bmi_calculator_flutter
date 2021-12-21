import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0D22),
        scaffoldBackgroundColor: Color(0xFF0A0D22),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1C1F32),
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 3.0,
          ),
        ),
        accentColor: Color(0xFFEB1555),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFEB1555),
          minWidth: double.infinity,
          splashColor: Colors.white,
          height: 55.0,
        ),
      ),
      home: HomePage(),
    );
  }
}
