import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../routes/app_routes.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({super.key});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _mrNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _upiIdController = TextEditingController();
  late AnimationController _animationController;

  String _selectedPaymentMethod = 'card';

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
    _mrNameController.dispose();
    _addressController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _upiIdController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handlePayment() {
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
                  'Payment Successful!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 8),
                Text(
                  'Your order has been confirmed',
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
                        'Payment',
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
                                'Order Details',
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
                                icon: Icons.medical_services_outlined,
                                delay: 400,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _mrNameController,
                                label: "MR Name",
                                icon: Icons.person_outline,
                                delay: 500,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _addressController,
                                label: "Delivery Address",
                                icon: Icons.location_on_outlined,
                                maxLines: 3,
                                delay: 600,
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'Payment Method',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ).animate()
                                .fadeIn(delay: 700.ms)
                                .slideX(begin: -0.2),
                              const SizedBox(height: 16),
                              _buildPaymentMethodSelector(),
                              const SizedBox(height: 24),
                              if (_selectedPaymentMethod == 'card') _buildCardFields(),
                              if (_selectedPaymentMethod == 'upi') _buildUPIFields(),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _handlePayment,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Pay Now',
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
    int? maxLines,
    TextInputType? keyboardType,
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
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
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
          if (value?.isEmpty ?? true) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: delay))
      .slideX(begin: -0.2);
  }

  Widget _buildPaymentMethodSelector() {
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
      child: Column(
        children: [
          _buildPaymentOption('card', 'Credit/Debit Card', Icons.credit_card),
          Divider(color: Colors.grey[200]),
          _buildPaymentOption('upi', 'UPI', Icons.payment),
          Divider(color: Colors.grey[200]),
          _buildPaymentOption('cod', 'Cash on Delivery', Icons.money),
        ],
      ),
    ).animate()
      .fadeIn(delay: 800.ms)
      .slideY(begin: 0.2);
  }

  Widget _buildPaymentOption(String value, String title, IconData icon) {
    final isSelected = _selectedPaymentMethod == value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardFields() {
    return Column(
      children: [
        _buildTextField(
          controller: _cardNumberController,
          label: "Card Number",
          icon: Icons.credit_card,
          keyboardType: TextInputType.number,
          delay: 900,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _expiryController,
                label: "MM/YY",
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                delay: 1000,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _cvvController,
                label: "CVV",
                icon: Icons.lock_outline,
                keyboardType: TextInputType.number,
                delay: 1100,
              ),
            ),
          ],
        ),
      ],
    ).animate()
      .fadeIn()
      .slideY(begin: 0.2);
  }

  Widget _buildUPIFields() {
    return _buildTextField(
      controller: _upiIdController,
      label: "UPI ID",
      icon: Icons.payment,
      keyboardType: TextInputType.text,
      delay: 900,
    ).animate()
      .fadeIn()
      .slideY(begin: 0.2);
  }
}