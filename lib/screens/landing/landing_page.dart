import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/screens/home_page/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:gokul_weds_vrinda/const/app_assets.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';
import 'package:gokul_weds_vrinda/providers/card_providers.dart';
import 'package:gokul_weds_vrinda/screens/landing/widgets/beating_heart_circle.dart';
import 'package:gokul_weds_vrinda/screens/landing/widgets/falling_hearts.dart';
import 'package:gokul_weds_vrinda/screens/landing/widgets/glare_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppAssets.leftLandingFlower), context);
    precacheImage(const AssetImage(AppAssets.rightLandingFlower), context);
    AppAssets.precacheAllAssets(context);
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final size = ScreenHelper.screenSize(context);
    final mobileCheck = ScreenHelper.isMobile(context);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.landingDarkRed, AppColors.landingDeepRed],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 2. Falling Hearts Animation Background
          const Positioned.fill(child: FallingHearts(count: 25)),

          // 3. Center Invitation Card
          SafeArea(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.9,
                      end: 1.0,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Padding(
                  key: const ValueKey('closed_card'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Container(
                    // Mobile-il width and height kooti portrait feel aakkunnu
                    width: mobileCheck ? size.width * 0.92 : 540,
                    constraints: BoxConstraints(
                      minHeight: mobileCheck
                          ? size.height * 0.72
                          : 410, // Height increased
                      maxHeight: mobileCheck
                          ? size.height * 0.88
                          : 600, // Height increased
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.landingCard,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(102),
                          blurRadius: 25,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Left Flower Asset
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              AppAssets.leftLandingFlower,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // Right Flower Asset
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              AppAssets.rightLandingFlower,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // Responsive Center Content with Scrollable safety
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              vertical: mobileCheck
                                  ? 48.0
                                  : 54.0, // Increased padding for more height distribution
                              horizontal: 24.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BeatingHeartCircle(isMobile: mobileCheck),
                                const SizedBox(height: 22),

                                // Groom Name
                                Text(
                                  'Gokul',
                                  style: GoogleFonts.cinzel(
                                    fontSize: mobileCheck ? 30 : 36,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.landingDeepRed,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                // Ampersand
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6.0,
                                  ),
                                  child: Text(
                                    '&',
                                    style: GoogleFonts.ebGaramond(
                                      fontSize: mobileCheck ? 20 : 24,
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.landingDeepRed,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // Bride Name
                                Text(
                                  'Vrinda',
                                  style: GoogleFonts.cinzel(
                                    fontSize: mobileCheck ? 30 : 36,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.landingDeepRed,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 20),

                                // Date
                                Text(
                                  'November 15, 2026',
                                  style: GoogleFonts.ebGaramond(
                                    fontSize: mobileCheck ? 18 : 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.landingDeepRed.withAlpha(
                                      230,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 10),

                                // Subtext
                                Text(
                                  'Cordially Invites',
                                  style: GoogleFonts.ebGaramond(
                                    fontSize: mobileCheck ? 15 : 17,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.landingDeepRed.withAlpha(
                                      200,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 15),

                                // Glare Button
                                GlareButton(
                                  text: 'Open',
                                  isMobile: mobileCheck,
                                  onTap: () {
                                    cardProvider.openCard();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
