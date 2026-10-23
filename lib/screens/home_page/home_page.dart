import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/screens/home_page/widgets/envolop.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            // Base warm off-white / ivory color
            color: Color(0xFFF9F6EE),
            image: DecorationImage(
              image: AssetImage('assets/images/background_cream.jpeg'),
              repeat: ImageRepeat.repeat,
              opacity: 0.85,
              // BlendMode allows the base color to show through the paper fibers
              colorFilter: ColorFilter.mode(
                Color(0xFFF7F4EA),
                BlendMode.multiply,
              ),
            ),
          ),
          child: Column(
            spacing: 20,
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
                          color: const Color(0xFF5A1A2B),
                        ),
                      ),
                      Text(
                        "Vrinda",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 64,
                          color: const Color(0xFF5A1A2B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
