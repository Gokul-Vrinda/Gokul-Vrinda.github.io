// lib/screens/home_page/widgets/guestbook_section.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:gokul_weds_vrinda/providers/guestbook_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gokul_weds_vrinda/widgets/custom_heading.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';
import 'package:provider/provider.dart';

class GuestbookSection extends StatefulWidget {
  const GuestbookSection({super.key});

  @override
  State<GuestbookSection> createState() => _GuestbookSectionState();
}

class _GuestbookSectionState extends State<GuestbookSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _wishesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch wishes when widget loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GuestbookProvider>(context, listen: false).fetchWishes();
    });
  }

  void _sendWishes() async {
    if (_nameController.text.isEmpty || _wishesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill in both name and wishes!",
            style: TextStyle(color: AppColors.fontColor),
          ),
          backgroundColor: AppColors.landingCard,
        ),
      );
      return;
    }

    final provider = Provider.of<GuestbookProvider>(context, listen: false);
    bool success = await provider.addWish(
      _nameController.text,
      _wishesController.text,
    );

    if (success) {
      _nameController.clear();
      _wishesController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Thank you for your wishes! ✨",
            style: TextStyle(color: AppColors.fontColor),),
            backgroundColor: AppColors.landingCard,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send wishes. Try again!",
            style: TextStyle(color: AppColors.landingCard),),
            backgroundColor: AppColors.landingDarkRed,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wishesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenHelper.isMobile(context);
    final guestbookProvider = Provider.of<GuestbookProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 650),
        padding: EdgeInsets.all(isMobile ? 20 : 40),
        decoration: BoxDecoration(
          color: const Color(0xFFF6EADB),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Guestbook Title
            const CustomHeading(
              text: "GUESTBOOK",
              mobileFontSize: 20,
              tabletFontSize: 24,
              desktopFontSize: 28,
            ),
            const SizedBox(height: 30),

            // Name Input Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter your name*",
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                filled: true,
                fillColor: const Color(0xFFF6EADB),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8A7A6A),
                    width: 0.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8A7A6A),
                    width: 0.8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF5A1A2B),
                    width: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Wishes Input Field (Multiline)
            TextField(
              controller: _wishesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter your wishes*",
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                filled: true,
                fillColor: const Color(0xFFF6EADB),
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8A7A6A),
                    width: 0.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8A7A6A),
                    width: 0.8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF5A1A2B),
                    width: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Action Row (Button & Loading state)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                guestbookProvider.isLoading
                    ? const CircularProgressIndicator(color: Color(0xFF4A1525))
                    : ElevatedButton(
                        onPressed: _sendWishes,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A1525),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          "SEND WISHES",
                          style: GoogleFonts.tinos(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 13,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 35),

            // Dynamic Empty State Check
            if (guestbookProvider.wishes.isEmpty)
              Text(
                "No wishes yet. Be the first!",
                style: GoogleFonts.tinos(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF7A6A5A),
                ),
              )
            else
              Text(
                "${guestbookProvider.wishes.length} wishes shared so far ✨",
                style: GoogleFonts.tinos(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF5A1A2B),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
