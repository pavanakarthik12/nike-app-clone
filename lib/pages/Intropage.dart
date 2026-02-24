import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/nike.jpg',
                height: 220,
              ),
              Column(
                children: [
                  Text(
                    "JUST DO IT",
                    style: GoogleFonts.oswald(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "PREMIUM SNEAKERS",
                    style: GoogleFonts.oswald(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => HomePage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 241, 197, 38),
                  ),
                  height: 52,
                  width: 200,
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