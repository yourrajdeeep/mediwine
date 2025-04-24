import 'package:demoapp/screens/doctor_details_screen.dart';
import 'package:demoapp/screens/pre_book_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/otp_verification_screen.dart';
import '../screens/set_new_password_screen.dart';
import '../screens/account_screen.dart';
import '../screens/schedule_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/payment_gateway_screen.dart';
import '../screens/product_catalog_screen.dart';
import '../screens/doctor_profiles_screen.dart';
import '../screens/analytics_dashboard_screen.dart';
import '../screens/visit_planner_screen.dart';
import '../screens/presentation_mode_screen.dart';
import '../screens/sales_tools_screen.dart';
import '../screens/product_details_screen.dart';
import '../controllers/visit_controller.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const otpVerification = '/otp-verification';
  static const setNewPassword = '/set-new-password';
  static const home = '/home';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const schedule = '/schedule';
  static const account = '/account';
  static const editProfile = '/edit-profile';
  static const payment = '/payment';
  static const String prebook = '/pre-book';
  static const String products = '/products';
  static const String doctorProfiles = '/doctor-profiles';
  static const String analytics = '/analytics';
  static const String visitPlanner = '/visit-planner';
  static const String presentation = '/presentation';
  static const String salesTools = '/sales-tools';
  static const String productDetails = '/product-details';
  static const String doctorDetails = '/doctor-details';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      middlewares: [_BackButtonMiddleware()],
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: otpVerification,
      page: () => const OtpVerificationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: setNewPassword,
      page: () => const SetNewPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: account,
      page: () => const AccountScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: schedule,
      page: () => ScheduleScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: payment,
      page: () => const PaymentGatewayScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: prebook,
      page: () => const PreBookScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: products,
      page: () => const ProductCatalogScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: doctorProfiles,
      page: () => const DoctorProfilesScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: analytics,
      page: () => const AnalyticsDashboardScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: visitPlanner,
      page: () => const VisitPlannerScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: presentation,
      page: () => const PresentationModeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: salesTools,
      page: () => const SalesToolsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: productDetails,
      page: () {
        final product = Get.arguments as Map<String, dynamic>;
        return ProductDetailsScreen(product: product);
      },
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: doctorDetails,
      page: () {
        final doctor = Get.arguments as Map<String, dynamic>;
        return DoctorDetailsScreen(doctor: doctor);
      },
      binding: BindingsBuilder(() {
        Get.lazyPut(() => VisitController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}

class _BackButtonMiddleware extends GetMiddleware {
  DateTime? _lastBackPress;

  @override
  Widget onPageBuilt(Widget page) {
    return WillPopScope(
      onWillPop: () async {
        // If there's a dialog or bottom sheet showing, close it
        if (Get.isDialogOpen ?? false) {
          Get.back();
          return false;
        }
        if (Get.isBottomSheetOpen ?? false) {
          Get.back();
          return false;
        }

        // If we're on the home screen, handle double-back to exit
        if (Get.currentRoute == AppRoutes.home) {
          if (_lastBackPress == null || 
              DateTime.now().difference(_lastBackPress!) > const Duration(seconds: 2)) {
            _lastBackPress = DateTime.now();
            Get.snackbar(
              'Exit App',
              'Press back again to exit',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
            return false;
          }
          return true;
        }

        // For other screens, show "Continue to iterate?" dialog
        final result = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Continue to iterate?'),
            content: const Text('Do you want to go back?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        if (result ?? false) {
          if (Get.previousRoute.isNotEmpty) {
            Get.back();
          } else {
            Get.offAllNamed(AppRoutes.home);
          }
        }
        return false;
      },
      child: page,
    );
  }
}