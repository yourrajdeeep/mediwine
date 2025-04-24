import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/home_controller.dart';
import '../controllers/visit_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_snackbar.dart';
import 'product_catalog_screen.dart';
import 'doctor_profiles_screen.dart';
import 'analytics_dashboard_screen.dart';
import 'visit_planner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  final VisitController visitController = Get.find<VisitController>();
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastBackPressed == null || 
            DateTime.now().difference(_lastBackPressed!) > const Duration(seconds: 2)) {
          _lastBackPressed = DateTime.now();
          CustomSnackbar.show(
            title: 'Exit App',
            message: 'Press back again to exit',
            isSuccess: false,
            duration: const Duration(seconds: 2),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
            _getTitle(controller.currentIndex.value),
            style: GoogleFonts.poppins(color: Colors.white),
          )),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.95),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
          
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => Get.toNamed(AppRoutes.notifications),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => Get.toNamed(AppRoutes.settings),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: Obx(() => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            ProductCatalogScreen(),
            DoctorProfilesScreen(),
            AnalyticsDashboardScreen(),
            VisitPlannerScreen(),
          ],
        )),
        bottomNavigationBar: Obx(() => NavigationBar(
          onDestinationSelected: controller.changeTab,
          selectedIndex: controller.currentIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.medical_services_outlined),
              selectedIcon: Icon(Icons.medical_services),
              label: 'Products',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Doctors',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined),
              selectedIcon: Icon(Icons.analytics),
              label: 'Analytics',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Planner',
            ),
          ],
        )),
        floatingActionButton: Obx(() {
          final fab = _getFloatingActionButton(controller.currentIndex.value);
          return fab ?? const SizedBox.shrink();
        }),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Products';
      case 1:
        return 'Doctor Profiles';
      case 2:
        return 'Analytics Dashboard';
      case 3:
        return 'Visit Planner';
      default:
        return 'MR App';
    }
  }

  Widget? _getFloatingActionButton(int index) {
    switch (index) {
      case 1:
        return FloatingActionButton(
          onPressed: () {
            // TODO: Add new doctor
          },
          child: const Icon(Icons.person_add),
        ).animate()
         .scale(duration: 200.ms)
         .fadeIn(duration: 200.ms);
      case 3:
        return FloatingActionButton(
          onPressed: () {
            // TODO: Add new visit
          },
          child: const Icon(Icons.add),
        ).animate()
         .scale(duration: 200.ms)
         .fadeIn(duration: 200.ms);
      default:
        return null;
    }
  }
}
