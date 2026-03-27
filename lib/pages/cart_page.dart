import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sneaker_item.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  final List<SneakerItem> cartItems;
  final ValueChanged<SneakerItem> onRemove;

  const CartPage({super.key, required this.cartItems, required this.onRemove});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get _total {
    return widget.cartItems.fold<double>(
      0,
      (total, item) => total + item.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart',
              style: GoogleFonts.oswald(
                color: AppPalette.textPrimary,
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.cartItems.length} item(s) selected',
              style: GoogleFonts.poppins(
                color: AppPalette.textMuted,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            if (widget.cartItems.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Your cart is empty.\nAdd sneakers from Shop.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: AppPalette.textMuted,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: widget.cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppPalette.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppPalette.accent.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.imagePath,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 64,
                                height: 64,
                                color: AppPalette.background,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported_rounded,
                                  color: AppPalette.textMuted,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: GoogleFonts.poppins(
                                    color: AppPalette.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  item.subtitle,
                                  style: GoogleFonts.poppins(
                                    color: AppPalette.textMuted,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${item.price.toStringAsFixed(0)}',
                                  style: GoogleFonts.oswald(
                                    color: AppPalette.accent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => widget.onRemove(item),
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            Container(
              margin: const EdgeInsets.only(bottom: 12, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppPalette.accent.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.poppins(
                      color: AppPalette.textMuted,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${_total.toStringAsFixed(0)}',
                    style: GoogleFonts.oswald(
                      color: AppPalette.accent,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
