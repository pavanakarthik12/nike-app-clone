import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_nav_bar.dart';
import 'package:flutter_application_1/models/sneaker_item.dart';
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
  final List<SneakerItem> _cartItems = [];

  final List<SneakerItem> _catalog = const [
    SneakerItem(
      id: 'shoe1',
      name: 'Air Zoom Nova',
      subtitle: 'Street Runner',
      price: 140,
      imagePath: 'assets/shoe1.jpg',
      category: 'Running',
      featuredScore: 92,
    ),
    SneakerItem(
      id: 'shoe2',
      name: 'Retro Blaze',
      subtitle: 'Court Classic',
      price: 125,
      imagePath: 'assets/shoe2.jpg',
      category: 'Classic',
      featuredScore: 88,
    ),
    SneakerItem(
      id: 'shoe3',
      name: 'Flex Drift',
      subtitle: 'Daily Comfort',
      price: 110,
      imagePath: 'assets/shoe3.jpg',
      category: 'Lifestyle',
      featuredScore: 85,
    ),
    SneakerItem(
      id: 'shoe4',
      name: 'Phantom Edge',
      subtitle: 'Performance Fit',
      price: 160,
      imagePath: 'assets/shoe4.jpg',
      category: 'Performance',
      featuredScore: 95,
    ),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToCart(SneakerItem item) {
    setState(() {
      _cartItems.add(item);
    });
  }

  void _removeFromCart(SneakerItem item) {
    setState(() {
      _cartItems.remove(item);
    });
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => navigateBottomBar(1),
                ),
                if (_cartItems.isNotEmpty)
                  Positioned(
                    right: 5,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_cartItems.length}',
                        style: GoogleFonts.poppins(
                          color: AppPalette.background,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
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
      body: _currentPage,
    );
  }

  Widget get _currentPage {
    switch (_selectedIndex) {
      case 1:
        return CartPage(cartItems: _cartItems, onRemove: _removeFromCart);
      case 0:
      default:
        return ShopPage(catalog: _catalog, onAddToCart: _addToCart);
    }
  }
}
