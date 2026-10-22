import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';

class BeatingHeartCircle extends StatefulWidget {
  final bool isMobile;
  final bool isPopup; // True anel elastic pop aakum, false anel normal beat aakum

  const BeatingHeartCircle({
    super.key,
    required this.isMobile,
    this.isPopup = false,
  });

  @override
  State<BeatingHeartCircle> createState() => _BeatingHeartCircleState();
}

class _BeatingHeartCircleState extends State<BeatingHeartCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    if (widget.isPopup) {
      // 1. Elastic Pop Animation when opened
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      );
      _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut, // Bouncy pop effect
        ),
      );
      _controller.forward();
    } else {
      // 2. Normal Continuous Beating Animation for Landing Page
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      )..repeat(reverse: true);

      _scaleAnimation = Tween<double>(begin: 0.88, end: 1.12).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double circleSize = widget.isMobile ? (widget.isPopup ? 54.0 : 46.0) : (widget.isPopup ? 64.0 : 52.0);
    final double iconSize = widget.isMobile ? (widget.isPopup ? 28.0 : 22.0) : (widget.isPopup ? 32.0 : 26.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              color: AppColors.landingDeepRed,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.landingDeepRed.withAlpha(120),
                  blurRadius: widget.isPopup ? 18 : 12,
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.favorite,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        );
      },
    );
  }
}