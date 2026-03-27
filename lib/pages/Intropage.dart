import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/theme/app_theme.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/nike.jpg', height: 250),
              Column(
                children: [
                  Text(
                    "JUST DO IT",
                    style: GoogleFonts.oswald(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppPalette.textPrimary,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "PREMIUM SNEAKERS",
                    style: GoogleFonts.oswald(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppPalette.textMuted,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppPalette.accent,
                  ),
                  height: 62,
                  width: 250,
                  child: Center(
                    child: Text(
                      "SHOP NOW",
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
