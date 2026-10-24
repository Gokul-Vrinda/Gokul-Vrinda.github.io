// lib/screens/home_page/widgets/venue_location_section.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';
import 'package:gokul_weds_vrinda/widgets/custom_heading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui_web' as ui_web; // Flutter web specific import for platform view
import 'package:web/web.dart'
    as web; // Modern package:web for Flutter web elements

class VenueLocationSection extends StatelessWidget {
  // Updated with your new location link
  static const String venueMapUrl =
      'https://maps.app.goo.gl/DHm8aQd2sYqvFCaB8';

  // Embed URL for Google Maps iFrame adjusted for the location
  static const String _mapEmbedUrl =
      'https://maps.google.com/maps?q=Sion+Centre+Pazhamthottam&t=&z=15&ie=UTF8&iwloc=&output=embed';

  const VenueLocationSection({super.key});

  Future<void> _launchMapUrl() async {
    final Uri uri = Uri.parse(venueMapUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback using direct web window open if launcher fails
        web.window.open(venueMapUrl, '_blank');
      }
    } catch (e) {
      debugPrint('Error launching map: $e');
      web.window.open(venueMapUrl, '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Register the iframe view factory for Flutter Web
    String htmlViewId = 'sion-centre-map-iframe';

    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(htmlViewId, (int viewId) {
      final web.HTMLIFrameElement iframe = web.HTMLIFrameElement()
        ..src = _mapEmbedUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
      return iframe;
    });

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          // Section Heading
          const CustomHeading(text: "WEDDING RECEPTION VENUE"),
          const SizedBox(height: 8),
          const CustomHeading(
            text: "Sion Centre Pazhamthottam",
            mobileFontSize: 10,
            tabletFontSize: 10,
            desktopFontSize: 10,
          ),

          const SizedBox(height: 30),

          // Map Container
          Center(
            child: Builder(
              builder: (context) {
                final isMobile = ScreenHelper.isMobile(context);

                return Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  height: isMobile ? 380 : 380, // Responsive container height
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Embedded True Google Map HTML View
                      const HtmlElementView(viewType: 'sion-centre-map-iframe'),

                      // Floating Info Card Overlay (Responsive Position & Sizing)
                      Positioned(
                        top: isMobile ? 12 : 20,
                        left: isMobile ? 12 : 20,
                        right: isMobile
                            ? 12
                            : null, // Stretch on mobile screens
                        child: Container(
                          width: isMobile ? null : 270,
                          padding: EdgeInsets.all(isMobile ? 10 : 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(245),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Sion Centre",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.tinos(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 14 : 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: _launchMapUrl,
                                    child: Icon(
                                      Icons.open_in_new,
                                      size: isMobile ? 16 : 18,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Pazhamthottam",
                                style: TextStyle(
                                  fontSize: isMobile ? 11 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "2C6H+W93, Pazhamthottam, Aikaranad North, Keralam",
                                style: TextStyle(
                                  fontSize: isMobile ? 9.5 : 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Get Directions Button
          TextButton.icon(
            onPressed: _launchMapUrl,
            icon: const Icon(Icons.navigation_outlined, color: AppColors.fontColor),
            label: Text(
              "Get directions",
              style: GoogleFonts.tinos(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.fontColor,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}