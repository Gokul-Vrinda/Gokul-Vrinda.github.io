import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_assets.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart'; // Helper file import cheyyuka

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenHelper use cheythu values edukkunnu
    final size = ScreenHelper.screenSize(context);
    final mobileCheck = ScreenHelper.isMobile(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.landingDarkRed, AppColors.landingDeepRed],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: mobileCheck ? size.width * 0.88 : 550,
                maxHeight: size.height * 0.75,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(102),
                    blurRadius: 25,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Image.asset(
                AppAssets.landingInvitationCard,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
