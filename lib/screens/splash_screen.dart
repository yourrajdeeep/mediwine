import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      // Check if we're coming from login screen
      if (Get.previousRoute == AppRoutes.login) {
        // Do nothing, let the login screen handle navigation
        return;
      }
      // Otherwise, navigate to login
      Get.offNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 120)
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(delay: 400.ms),
            const SizedBox(height: 24),
            Text(
              'Demo App',
              style: Theme.of(context).textTheme.headlineLarge,
            )
                .animate()
                .fadeIn(delay: 400.ms)
                .slideY(
                  begin: 0.2,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                ),
            const SizedBox(height: 8),
            Text(
              'Your Daily Companion',
              style: Theme.of(context).textTheme.bodyLarge,
            )
                .animate()
                .fadeIn(delay: 600.ms)
                .slideY(
                  begin: 0.2,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }
}