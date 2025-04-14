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
            Container(
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
                        tag: 'profile-photo',
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: const AssetImage('assets/images/profile.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hello user!',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                    Text(
                      'user@example.com',
                      style: GoogleFonts.poppins(
                        color: theme.scaffoldBackgroundColor,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...['Cardiovascular', 'Respiratory', 'Orthopedic', 'Neurology', 
                'Dermatology', 'Other organ systems']
                .map(
                  (category) => ListTile(
                    dense: true,
                    leading: Icon(Icons.medical_services_outlined, 
                      color: theme.primaryColor.withOpacity(0.8)),
                    title: Text(category, 
                      style: GoogleFonts.poppins(fontSize: 14)),
                    onTap: () async {
                      Get.back();
                      await controller.changeCategory(category);
                    },
                  ),
                ),
            Divider(color: theme.dividerColor.withOpacity(0.3)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Account',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                ),
              ),
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
              onTap: () => Get.toNamed(AppRoutes.notifications),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.account_box_outlined, color: theme.primaryColor),
              title: Text('Update Account', style: GoogleFonts.poppins(fontSize: 14)),
              onTap: () => Get.toNamed(AppRoutes.account),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.settings_outlined, color: theme.primaryColor),
              title: Text('Settings', style: GoogleFonts.poppins(fontSize: 14)),
              onTap: () => Get.toNamed(AppRoutes.settings),
            ),
            const Divider(),
            ListTile(
              dense: true,
              leading: Icon(Icons.logout_outlined, 
                color: theme.colorScheme.error.withOpacity(0.8)),
              title: Text('Logout', 
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.error,
                )),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: Row(
                      children: [
                        Icon(Icons.logout_rounded, color: theme.colorScheme.error),
                        const SizedBox(width: 10),
                        Text('Logout', 
                          style: GoogleFonts.poppins(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ],
                    ),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black87
                      )
                    ),
                    actions: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[800],
                          ),
                          child: Text('Cancel',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.offAll(
                              () => const LoginScreen(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Logout',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  transitionCurve: Curves.easeInOut,
                  transitionDuration: const Duration(milliseconds: 300),
                  barrierDismissible: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
