import 'package:demoapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';
import '../widgets/app_drawer.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  late VideoPlayerController _video1Controller;
  late VideoPlayerController _video3Controller;
  bool _video1Ready = false;
  bool _video3Ready = false;

  @override
  void initState() {
    super.initState();
    _video1Controller = VideoPlayerController.asset('assets/video/product_video1.mp4')
      ..setLooping(true);
    _video3Controller = VideoPlayerController.asset('assets/video/product_video3.mp4')
      ..setLooping(true);
    
    _video1Controller.initialize().then((_) {
      _video1Controller.play();
      setState(() => _video1Ready = true);
    });
    
    _video3Controller.initialize().then((_) {
      _video3Controller.play();
      setState(() => _video3Ready = true);
    });
  }

  @override
  void dispose() {
    _video1Controller.dispose();
    _video3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.selectedCategory.value,
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            )),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.95),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Company Title and Product Details
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                height: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Title',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Detailed product description goes here',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Hero(
                        tag: 'product_image',
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/product.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate()
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.2, duration: 400.ms),
            ),

            // Tagline
            Positioned(
              top: 192,
              left: 16,
              right: 16,
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Your Health, Our Priority',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 400.ms)
                .slideX(begin: 0.2, duration: 400.ms),
            ),

            // Demo Video and Benefits
            Positioned(
              top: 288,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 240,
                child: Stack(
                  children: [
                    // Demo Video
                    Positioned(
                      left: 0,
                      top: 0,
                      width: (screenWidth - 48) / 2,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: _video1Ready 
                                  ? AspectRatio(
                                      aspectRatio: _video1Controller.value.aspectRatio,
                                      child: VideoPlayer(_video1Controller),
                                    )
                                  : const Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                child: _video3Ready
                                  ? AspectRatio(
                                      aspectRatio: _video3Controller.value.aspectRatio,
                                      child: VideoPlayer(_video3Controller),
                                    )
                                  : const Center(child: CircularProgressIndicator()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Benefits
                    Positioned(
                      right: 0,
                      top: 0,
                      width: (screenWidth - 48) / 2,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Text(
                              'Benefits',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...List.generate(3, (index) => Positioned(
                              top: 50 + (index * 40),
                              left: 16,
                              right: 16,
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 8),
                                  Text('Benefit ${index + 1}',
                                      style: GoogleFonts.poppins()),
                                ],
                              ).animate()
                                .fadeIn(delay: (600 + index * 100).ms)
                                .slideX(begin: 0.2, duration: 400.ms),
                            )).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Product Composition
            Positioned(
              top: 544,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Theme.of(context).primaryColor.withOpacity(0.05),
                                child: Text('Component',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Theme.of(context).primaryColor.withOpacity(0.05),
                                child: Text('Quantity',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        ...List.generate(
                          3,
                          (index) => TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Component ${index + 1}',
                                      style: GoogleFonts.poppins()),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${index + 1}0mg',
                                      style: GoogleFonts.poppins()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate()
                    .fadeIn(delay: 800.ms, duration: 400.ms)
                    .slideY(begin: 0.2, duration: 400.ms),
                  
                  // Action Buttons
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(AppRoutes.payment),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'Order Now',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ).animate()
                          .fadeIn(delay: 900.ms, duration: 400.ms)
                          .slideY(begin: 0.2, duration: 400.ms),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.toNamed(AppRoutes.prebook),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Pre-book',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ).animate()
                          .fadeIn(delay: 1000.ms, duration: 400.ms)
                          .slideY(begin: 0.2, duration: 400.ms),
                      ],
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
