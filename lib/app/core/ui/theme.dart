import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

sealed class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.greenLight,
        minimumSize: const Size.fromHeight(52),
        textStyle: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.2),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: AppColor.greenLight,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.greenLight)),
      border: const OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: AppColor.green,
        foregroundColor: AppColor.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        textStyle: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.2),
      ),
    ),
  );
}
