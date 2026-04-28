import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static TextStyle get headingStyle => GoogleFonts.outfit(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get subHeadingStyle => GoogleFonts.outfit(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyStyle =>
      GoogleFonts.outfit(fontSize: 14.sp, color: AppColors.textSecondary);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.primaryLight,
        surface: AppColors.surfaceColor,
        error: AppColors.errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primaryLight),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceColor,
        hintStyle: TextStyle(color: AppColors.textHint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderColor,
        thickness: 0.5,
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.outfit(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.outfit(color: AppColors.textPrimary),
        bodyMedium: GoogleFonts.outfit(color: AppColors.textSecondary),
        bodySmall: GoogleFonts.outfit(color: AppColors.textHint),
      ),
    );
  }
}
