import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _priceAlerts = true;
  bool _autoPlayVideos = false;

  Widget _settingSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppPalette.accent.withValues(alpha: 0.25)),
      ),
      child: SwitchListTile.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppPalette.accent,
        secondary: Icon(icon, color: AppPalette.accent),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: AppPalette.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(color: AppPalette.textMuted, fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: GoogleFonts.oswald(
            color: AppPalette.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App Preferences',
                style: GoogleFonts.oswald(
                  color: AppPalette.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Tune the shopping experience your way.',
                style: GoogleFonts.poppins(
                  color: AppPalette.textMuted,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _settingSwitchTile(
                      title: 'Push Notifications',
                      subtitle: 'Get updates for offers and launches',
                      value: _notifications,
                      onChanged: (value) =>
                          setState(() => _notifications = value),
                      icon: Icons.notifications_active_outlined,
                    ),
                    _settingSwitchTile(
                      title: 'Price Drop Alerts',
                      subtitle: 'Notify when wishlist items get cheaper',
                      value: _priceAlerts,
                      onChanged: (value) =>
                          setState(() => _priceAlerts = value),
                      icon: Icons.local_offer_outlined,
                    ),
                    _settingSwitchTile(
                      title: 'Auto-play Product Videos',
                      subtitle: 'Preview videos automatically on product cards',
                      value: _autoPlayVideos,
                      onChanged: (value) =>
                          setState(() => _autoPlayVideos = value),
                      icon: Icons.play_circle_outline_rounded,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.accent,
                    foregroundColor: AppPalette.background,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preferences saved')),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: Text(
                    'Save Preferences',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
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
