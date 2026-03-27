import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_application_1/theme/app_theme.dart';

class MybottomNavbar extends StatelessWidget {
  final ValueChanged<int>? onTabChange;
  const MybottomNavbar({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GNav(
        color: AppPalette.textMuted,
        activeColor: AppPalette.background,
        tabActiveBorder: Border.all(color: AppPalette.accent),
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        tabBackgroundColor: AppPalette.accent,
        onTabChange: (value) => onTabChange?.call(value),
        gap: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppPalette.background,
        ),
        tabs: const [
          GButton(icon: Icons.home_rounded, text: "Shop", iconSize: 30),
          GButton(
            icon: Icons.shopping_cart_rounded,
            text: "Cart",
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
