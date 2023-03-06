import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yoboshu_cares_project/screens/mindful_meal_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.asapTextTheme(),
        primaryTextTheme: GoogleFonts.asapTextTheme(),
      ),
      home: const MindfulMealTimer(),
    );
  }
}
