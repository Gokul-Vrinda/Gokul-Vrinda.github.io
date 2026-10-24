import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_assets.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/providers/audio_provider.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/ceremony_info.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/envolop.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/guestbook_section.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/music_button.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/photo_gallery.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/reception_info.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/venue_location_section.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/wish_list_section.dart';
import 'package:gokul_weds_vrinda/widgets/colnrow_wordmark.dart';
import 'package:gokul_weds_vrinda/widgets/custom_heading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppAssets.precacheAllAssets(context);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    if (audioProvider.isPlaying) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      if (_pulseController.isAnimating) {
        _pulseController.stop();
      }
    }
    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF3E3C3),
              image: DecorationImage(
                image: AssetImage(AppAssets.background),
                opacity: 0.85,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFFF7F4EA),
                  BlendMode.multiply,
                ),
              ),
            ),
            child: Column(
              spacing: 50,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Envolop(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "&",
                      style: GoogleFonts.theNautigal(
                        fontSize: 160,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF8A7A6A).withOpacity(0.25),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Gokul",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 64,
                            color: AppColors.fontColor,
                          ),
                        ),
                        Text(
                          "Vrinda",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 64,
                            color: AppColors.fontColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Example usage:
                CeremonyInfo(),
                CustomHeading(text: "Photo Gallery"),
                PhotoGallery(),
                ReceptionInfo(),
                SizedBox.shrink(),
                const VenueLocationSection(),
                SizedBox.shrink(),
                GuestbookSection(),

                Text(
                  "Your presence would be the greatest gift we could receive!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tinos(
                    fontSize: 13,
                    color: AppColors.fontColor,
                  ),
                ),
                WishesListSection(),
                SizedBox.shrink(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ColnrowWordmark(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: MusicButton(),
    );
  }
}
