import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', 
          style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSection(
            title: 'App Preferences',
            children: [
              _buildSettingTile(
                context: context,
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Switch between light and dark theme',
                trailing: Switch(
                  value: Get.isDarkMode,
                  onChanged: (value) {
                    Get.changeThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
              _buildSettingTile(
                context: context,
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  // TODO: Implement language selection
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Medical Records',
            children: [
              _buildSettingTile(
                context: context,
                icon: Icons.history_outlined,
                title: 'Visit History',
                subtitle: 'View and manage your visit records',
                onTap: () {
                  // TODO: Implement visit history
                },
              ),
              _buildSettingTile(
                context: context,
                icon: Icons.file_download_outlined,
                title: 'Export Records',
                subtitle: 'Download your medical records',
                onTap: () {
                  // TODO: Implement export functionality
                },
              ),
            ],
          ),
          _buildSection(
            title: 'App Information',
            children: [
              _buildSettingTile(
                context: context,
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  // TODO: Show about dialog
                },
              ),
              _buildSettingTile(
                context: context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  // TODO: Show privacy policy
                },
              ),
              _buildSettingTile(
                context: context,
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () {
                  // TODO: Show terms of service
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: GoogleFonts.poppins()),
      subtitle: subtitle != null 
        ? Text(subtitle, style: GoogleFonts.poppins(fontSize: 12))
        : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}