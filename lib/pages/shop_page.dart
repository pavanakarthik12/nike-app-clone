import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sneaker_item.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPage extends StatefulWidget {
  final List<SneakerItem> catalog;
  final ValueChanged<SneakerItem> onAddToCart;

  const ShopPage({super.key, required this.catalog, required this.onAddToCart});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'All';
  bool _dealsOnly = false;
  String _sortBy = 'Featured';

  String _normalize(String input) {
    return input.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  int _compareItems(SneakerItem a, SneakerItem b) {
    if (_sortBy == 'Price: Low to High') {
      return a.price.compareTo(b.price);
    }
    if (_sortBy == 'Price: High to Low') {
      return b.price.compareTo(a.price);
    }
    if (_sortBy == 'Name') {
      return a.name.compareTo(b.name);
    }
    return b.featuredScore.compareTo(a.featuredScore);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SneakerItem> get _filteredItems {
    final normalizedQuery = _normalize(_query);
    final tokens = normalizedQuery.isEmpty
        ? <String>[]
        : normalizedQuery.split(' ');

    final filtered = widget.catalog.where((item) {
      if (_selectedCategory != 'All' && item.category != _selectedCategory) {
        return false;
      }
      if (_dealsOnly && item.price > 130) {
        return false;
      }

      if (tokens.isEmpty) {
        return true;
      }

      final searchable = _normalize(
        '${item.name} ${item.subtitle} ${item.category} ${item.price.toStringAsFixed(0)}',
      );
      return tokens.every((token) => searchable.contains(token));
    }).toList();

    filtered.sort(_compareItems);

    return filtered;
  }

  List<String> get _categories {
    final values = widget.catalog.map((item) => item.category).toSet().toList();
    values.sort((a, b) => a.compareTo(b));
    return ['All', ...values];
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Your Pair',
              style: GoogleFonts.oswald(
                color: AppPalette.textPrimary,
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Bold silhouettes, premium details.',
              style: GoogleFonts.poppins(
                color: AppPalette.textMuted,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppPalette.accent.withValues(alpha: 0.25),
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                textInputAction: TextInputAction.search,
                style: GoogleFonts.poppins(color: AppPalette.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search shoes...',
                  hintStyle: GoogleFonts.poppins(color: AppPalette.textMuted),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppPalette.accent,
                  ),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppPalette.textMuted,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final selected = category == _selectedCategory;
                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    labelStyle: GoogleFonts.poppins(
                      color: selected
                          ? AppPalette.background
                          : AppPalette.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    selectedColor: AppPalette.accent,
                    backgroundColor: AppPalette.surface,
                    side: BorderSide(
                      color: AppPalette.accent.withValues(
                        alpha: selected ? 0 : 0.3,
                      ),
                    ),
                    showCheckmark: false,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppPalette.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _sortBy,
                        dropdownColor: AppPalette.surface,
                        iconEnabledColor: AppPalette.accent,
                        style: GoogleFonts.poppins(
                          color: AppPalette.textPrimary,
                          fontSize: 13,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Featured',
                            child: Text('Featured'),
                          ),
                          DropdownMenuItem(
                            value: 'Price: Low to High',
                            child: Text('Price: Low to High'),
                          ),
                          DropdownMenuItem(
                            value: 'Price: High to Low',
                            child: Text('Price: High to Low'),
                          ),
                          DropdownMenuItem(value: 'Name', child: Text('Name')),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _sortBy = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppPalette.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Deals',
                        style: GoogleFonts.poppins(
                          color: AppPalette.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Switch.adaptive(
                        value: _dealsOnly,
                        activeColor: AppPalette.accent,
                        onChanged: (value) {
                          setState(() {
                            _dealsOnly = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${filtered.length} result(s)',
              style: GoogleFonts.poppins(
                color: AppPalette.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No sneakers match your search.',
                        style: GoogleFonts.poppins(color: AppPalette.textMuted),
                      ),
                    )
                  : GridView.builder(
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.64,
                          ),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppPalette.surface,
                                AppPalette.background,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: AppPalette.accent.withValues(alpha: 0.22),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      color: AppPalette.background,
                                      child: Image.asset(
                                        item.imagePath,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (_, __, ___) => Container(
                                          color: AppPalette.surface,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.image_not_supported_rounded,
                                            color: AppPalette.textMuted,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: AppPalette.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  item.subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: AppPalette.textMuted,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '\$${item.price.toStringAsFixed(0)}',
                                      style: GoogleFonts.oswald(
                                        color: AppPalette.accent,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 34,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppPalette.accent,
                                          foregroundColor:
                                              AppPalette.background,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          widget.onAddToCart(item);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${item.name} added to cart',
                                              ),
                                              duration: const Duration(
                                                milliseconds: 900,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add_shopping_cart_rounded,
                                          size: 16,
                                        ),
                                        label: Text(
                                          'Add',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
