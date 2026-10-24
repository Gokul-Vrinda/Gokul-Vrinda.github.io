// lib/screens/home_page/widgets/wishes_list_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';
import 'package:gokul_weds_vrinda/providers/guestbook_provider.dart';

class WishesListSection extends StatefulWidget {
  const WishesListSection({super.key});

  @override
  State<WishesListSection> createState() => _WishesListSectionState();
}

class _WishesListSectionState extends State<WishesListSection> {
  @override
  void initState() {
    super.initState();
    // Widget load aavumbol thanne wishes fetch cheythu thudangum
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GuestbookProvider>(context, listen: false).fetchWishes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenHelper.isMobile(context);

    // Consumer vazhi GuestbookProvider listen cheyyunnu
    return Consumer<GuestbookProvider>(
      builder: (context, guestbookProvider, child) {
        final wishes = guestbookProvider.wishes;

        
        if (wishes.isEmpty) {
          return const SizedBox.shrink(); 
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: isMobile ? 16 : 20),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              height: 500, // Fixed height with scrollbar matching the look
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: wishes.length,
                  itemBuilder: (context, index) {
                    final wish = wishes[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.landingCard, // Classic wedding cream tone
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE0D8CC),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(15),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Row: Name and Date/Time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                wish.name,
                                style: GoogleFonts.tinos(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color(0xFF3A101A),
                                ),
                              ),
                              Text(
                                wish.formattedDateTime, // Assuming WishModel has formatted date
                                style: GoogleFonts.tinos(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Message Body
                          Text(
                            wish.message,
                            style: GoogleFonts.tinos(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}