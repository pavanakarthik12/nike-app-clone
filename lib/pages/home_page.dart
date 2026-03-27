import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_nav_bar.dart';
import 'package:flutter_application_1/pages/cart_page.dart';
import 'package:flutter_application_1/pages/shop_page.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [const ShopPage(), const CartPage()];

  void _selectPageFromDrawer(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  Widget _drawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppPalette.background.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppPalette.accent),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: AppPalette.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppPalette.textMuted,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MybottomNavbar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppPalette.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(18, 44, 18, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppPalette.background, AppPalette.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(
                  bottom: BorderSide(
                    color: AppPalette.accent.withValues(alpha: 0.35),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 86,
                    child: Image.asset('assets/nike.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'SNEAKER HUB',
                    style: GoogleFonts.oswald(
                      color: AppPalette.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Premium street collection',
                    style: GoogleFonts.poppins(
                      color: AppPalette.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _drawerTile(
              icon: Icons.storefront_rounded,
              title: 'Shop',
              onTap: () => _selectPageFromDrawer(0),
            ),
            _drawerTile(
              icon: Icons.shopping_bag_rounded,
              title: 'Cart',
              onTap: () => _selectPageFromDrawer(1),
            ),
            _drawerTile(
              icon: Icons.favorite_outline_rounded,
              title: 'Wishlist',
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wishlist coming soon')),
                );
              },
            ),
            _drawerTile(
              icon: Icons.settings_rounded,
              title: 'Settings',
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming soon')),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppPalette.accent.withValues(alpha: 0.55),
                  ),
                  foregroundColor: AppPalette.accent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.logout_rounded),
                label: Text(
                  'Close Menu',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
