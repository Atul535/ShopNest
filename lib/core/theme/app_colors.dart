import 'package:flutter/material.dart';

class AppColors {
  // Core brand
  static const Color primaryColor    = Color(0xFFEA580C); // Orange 600 — buttons, CTAs
  static const Color primaryDark     = Color(0xFFC2410C); // Orange 700 — pressed states
  static const Color primaryLight    = Color(0xFFFB923C); // Orange 400 — links, accents

  // Backgrounds (dark theme)
  static const Color backgroundColor = Color(0xFF1C1917); // Stone 900 — main bg
  static const Color surfaceColor    = Color(0xFF292524); // Stone 800 — cards, inputs
  static const Color surfaceHighColor= Color(0xFF44403C); // Stone 700 — elevated cards

  // App bar
  static const Color appBarColor     = Color(0xFF111827); // Gray 900 — deep dark bar

  // Text
  static const Color textPrimary     = Color(0xFFFEF3C7); // Amber 50 — headings
  static const Color textSecondary   = Color(0xFFA8A29E); // Stone 400 — subtext
  static const Color textHint        = Color(0xFF6B7280); // Gray 500 — placeholders

  // Borders & dividers
  static const Color borderColor     = Color(0xFF44403C); // Stone 700 — input borders
  static const Color dividerColor    = Color(0xFF292524); // Stone 800 — dividers

  // Semantic
  static const Color whiteColor      = Colors.white;
  static const Color green           = Color(0xFF22C55E); // Success / in stock
  static const Color errorColor      = Color(0xFFEF4444); // Error / out of stock
  static const Color saleColor       = Color(0xFFFB923C); // Sale / deal badges
  static const Color badgeBg         = Color(0xFF7C2D12); // Deal badge background
  static const Color badgeText       = Color(0xFFFED7AA); // Deal badge text
}