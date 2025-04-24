import 'package:demoapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final theme = Theme.of(context);
    
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(theme),
            _buildMainSection(theme),
            _buildAccountSection(theme),
            _buildSettingsSection(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.primaryColor,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.account),
              child: Hero(
                tag: 'profile-photo-drawer',
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Icon(
                    Icons.person_outline,
                    size: 35,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Subashis Samanta',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              'Medical Representative',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Main Menu',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
            ),
          ),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.medical_services_outlined, color: theme.primaryColor),
          title: Text('Products', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Get.back();
            Get.find<HomeController>().changeTab(0);
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.people_outline, color: theme.primaryColor),
          title: Text('Doctors', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Get.back();
            Get.find<HomeController>().changeTab(1);
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.analytics_outlined, color: theme.primaryColor),
          title: Text('Analytics', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Get.back();
            Get.find<HomeController>().changeTab(2);
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.calendar_month_outlined, color: theme.primaryColor),
          title: Text('Visit Planner', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Get.back();
            Get.find<HomeController>().changeTab(3);
          },
        ),
      ],
    );
  }

  Widget _buildAccountSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Account',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
            ),
          ),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.person_outline, color: theme.primaryColor),
          title: Text('My Profile', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () => Get.toNamed(AppRoutes.account),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.calendar_today_outlined, color: theme.primaryColor),
          title: Text('Schedule', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () => Get.toNamed(AppRoutes.schedule),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.notifications_outlined, color: theme.primaryColor),
          title: Text('Notifications', style: GoogleFonts.poppins(fontSize: 14)),
          trailing: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              '3',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          onTap: () => Get.toNamed(AppRoutes.notifications),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Settings',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
            ),
          ),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.settings_outlined, color: theme.primaryColor),
          title: Text('Settings', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () => Get.toNamed(AppRoutes.settings),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.help_outline, color: theme.primaryColor),
          title: Text('Help & Support', style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            // TODO: Implement help & support
            Get.snackbar(
              'Coming Soon',
              'Help & Support feature will be available soon',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout, color: Colors.red),
          title: Text('Logout', style: GoogleFonts.poppins(fontSize: 14, color: const Color.fromARGB(255, 255, 8, 8))),
          onTap: () => Get.offAllNamed(AppRoutes.login),
        ),
      ],
    );
  }
}
