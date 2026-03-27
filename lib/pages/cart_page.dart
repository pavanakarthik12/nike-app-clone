import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CART",
              style: GoogleFonts.oswald(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.5,
                color: AppPalette.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Your selected sneakers.",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppPalette.textMuted,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppPalette.accent.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cart is empty",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppPalette.textPrimary,
                    ),
                  ),
                  Icon(Icons.shopping_bag_outlined, color: AppPalette.accent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
