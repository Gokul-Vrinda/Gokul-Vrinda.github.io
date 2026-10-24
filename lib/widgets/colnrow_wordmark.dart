// lib/widgets/colnrow_wordmark.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColnrowWordmark extends StatelessWidget {
  final double fontSize;
  final Color? textColor;

  const ColnrowWordmark({
    super.key,
    this.fontSize = 14.0,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "DESIGNED BY",
          style: GoogleFonts.urbanist(
            fontSize: fontSize * 0.75,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.0,
            color: (textColor ?? const Color(0xFF6A5A4A)).withAlpha(180),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "COLNROW",
          style: GoogleFonts.urbanist(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.5,
            color: textColor ?? const Color(0xFF4A1525),
          ),
        ),
      ],
    );
  }
}