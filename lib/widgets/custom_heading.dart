// lib/widgets/responsive_heading.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeading extends StatelessWidget {
  final String text;
  final Color? color;
  final double? mobileFontSize;
  final double? tabletFontSize;
  final double? desktopFontSize;

  const CustomHeading({
    super.key,
    required this.text,
    this.color,
    this.mobileFontSize,
    this.tabletFontSize,
    this.desktopFontSize,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize;
    if (ScreenHelper.isMobile(context)) {
      fontSize = mobileFontSize ?? 16.0;
    } else if (ScreenHelper.isTablet(context)) {
      fontSize = tabletFontSize ?? 18.0;
    } else {
      fontSize = desktopFontSize ?? 24.0;
    }

    return Text(
      text.toUpperCase(),
      style: GoogleFonts.tinos(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: color ?? AppColors.fontColor,
      ),
    );
  }
}
