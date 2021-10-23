import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_teacher_age/pages/guess_page/guess_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.prompt().fontFamily,
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 30.0),
          bodyText2: TextStyle(fontSize: 24.0),
        ),
      ),
      home: const GuessAge(),
    );
  }
}

