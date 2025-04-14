import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../routes/app_routes.dart';

class PreBookScreen extends StatefulWidget {
  const PreBookScreen({super.key});

  @override
  State<PreBookScreen> createState() => _PreBookScreenState();
}

class _PreBookScreenState extends State<PreBookScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _chamberNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _specialityController = TextEditingController();
  final _timeSlotController = TextEditingController();
  final _notesController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _chamberNumberController.dispose();
    _addressController.dispose();
    _specialityController.dispose();
    _timeSlotController.dispose();
    _notesController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handlePreBook() {
    if (_formKey.currentState?.validate() ?? false) {
      Get.dialog(
        AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Theme.of(context).primaryColor,
                    size: 48,
                  ),
                ).animate(delay: 200.ms).scale(
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                ),
                const SizedBox(height: 24),
                Text(
                  'Pre-Booking Confirmed!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 8),
                Text(
                  'Your pre-booking request has been received',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.home),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Browse More',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ).animate(delay: 800.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                    Colors.grey[100]!,
                  ],
                  stops: const [0.0, 0.2, 0.3],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pre-Book Product',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.2),

                // Form content
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Doctor Information',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ).animate()
                                .fadeIn(delay: 200.ms)
                                .slideX(begin: -0.2),
                              const SizedBox(height: 24),
                              _buildTextField(
                                controller: _doctorNameController,
                                label: "Doctor's Name",
                                icon: Icons.person_outline,
                                hint: "Enter doctor's full name",
                                delay: 400,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _specialityController,
                                label: "Speciality",
                                icon: Icons.medical_services_outlined,
                                hint: "Enter doctor's speciality",
                                delay: 500,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _chamberNumberController,
                                label: "Chamber Number",
                                icon: Icons.numbers_outlined,
                                hint: "Enter chamber number",
                                delay: 600,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _addressController,
                                label: "Chamber Address",
                                icon: Icons.location_on_outlined,
                                hint: "Enter complete chamber address",
                                maxLines: 3,
                                delay: 700,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _timeSlotController,
                                label: "Preferred Time Slot",
                                icon: Icons.access_time,
                                hint: "Enter preferred time slot",
                                delay: 800,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _notesController,
                                label: "Additional Notes",
                                icon: Icons.note_outlined,
                                hint: "Any additional information",
                                maxLines: 3,
                                isRequired: false,
                                delay: 900,
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _handlePreBook,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Pre-Book Now',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ).animate()
                                .fadeIn(delay: 1000.ms)
                                .slideY(begin: 0.2),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    int? maxLines,
    bool isRequired = true,
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.grey[800],
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[400],
          ),
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: (value) {
          if (isRequired && (value?.isEmpty ?? true)) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: delay))
      .slideX(begin: -0.2);
  }
}