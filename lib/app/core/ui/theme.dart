import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

sealed class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColor.green,
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
      fillColor: AppColor.grey,
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(color: AppColor.greenLight)),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
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
