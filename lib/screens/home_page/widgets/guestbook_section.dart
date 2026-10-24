// lib/screens/home_page/widgets/guestbook_section.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_assets.dart';
import 'package:gokul_weds_vrinda/const/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gokul_weds_vrinda/widgets/custom_heading.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';

class GuestbookSection extends StatefulWidget {
  const GuestbookSection({super.key});

  @override
  State<GuestbookSection> createState() => _GuestbookSectionState();
}

class _GuestbookSectionState extends State<GuestbookSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _wishesController = TextEditingController();

  void _sendWishes() {
    if (_nameController.text.isEmpty || _wishesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in both name and wishes!",style: TextStyle(color: AppColors.fontColor),),
          backgroundColor: AppColors.landingCard,
        ),
      );
      return;
    }
    // Handle saving wishes logic here (Firebase / API etc.)
    debugPrint(
      "Name: ${_nameController.text}, Wishes: ${_wishesController.text}",
    );

    // Clear fields
    _nameController.clear();
    _wishesController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thank you for your wishes! ✨")),
    );
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

    return Container(
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

          // Action Row (Button & Optional icon)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _sendWishes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A1525), // Deep maroon theme
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

          // Empty State Message
          Text(
            "No wishes yet. Be the first!",
            style: GoogleFonts.tinos(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF7A6A5A),
            ),
          ),
        ],
      ),
    );
  }
}
