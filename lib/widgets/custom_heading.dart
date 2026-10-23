// lib/widgets/responsive_heading.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeading extends StatelessWidget {
  final String text;
  final Color? color;
  
  const CustomHeading({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // ScreenHelper vech screen size-kku anusrichu font size responsive aakkunnu
    double fontSize;
    if (ScreenHelper.isMobile(context)) {
      fontSize = 16.0; // Mobile size
    } else if (ScreenHelper.isTablet(context)) {
      fontSize = 24.0; // Tablet size
    } else {
      fontSize = 32.0; // Desktop size
    }

    return Text(
      text.toUpperCase(), 
      style: GoogleFonts.tinos(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.5,
        color: color ?? AppColors.fontColor, // Default color if not provided
      ),
    );
  }
}