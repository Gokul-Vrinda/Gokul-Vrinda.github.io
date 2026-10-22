import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';

class GlareButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isMobile;

  const GlareButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<GlareButton> createState() => _GlareButtonState();
}

class _GlareButtonState extends State<GlareButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = widget.isMobile ? 130 : 150;
    final double buttonHeight = widget.isMobile ? 42 : 46;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.landingDeepRed,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withAlpha(200),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.landingDeepRed.withAlpha(120),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Button Text
              Text(
                widget.text,
                style: GoogleFonts.ebGaramond(
                  fontSize: widget.isMobile ? 18 : 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFAF5EF),
                  letterSpacing: 0.8,
                ),
              ),

              // 2. Smooth Faded Glare Sweep Effect
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(_controller.value * 3.5 - 1.2, 0.0),
                    child: Transform.rotate(
                      angle: 0, // Slanted glare
                      child: Container(
                        width: 45,
                        height: buttonHeight , // Full top-bottom coverage
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            stops: const [0.0, 0.5, 1.0],
                            colors: [
                              Colors.white.withAlpha(0),
                              Colors.white.withAlpha(90), // Soft glass shine
                              Colors.white.withAlpha(0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}