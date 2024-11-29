import 'package:flutter/material.dart';
import 'package:fraser_hacks/homeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

Color kThemeColour = Color(0xFF34495E);
Color kDarkGrey = Color(0xFF26252F);
Color kGrey = Color(0xFFD9D9D9);
Color kText = Color(0xFF5C5C5C);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
        primaryTextTheme: GoogleFonts.senTextTheme(),
        fontFamily: GoogleFonts.sen().fontFamily,
        textTheme: GoogleFonts.senTextTheme()),
  ));
}
