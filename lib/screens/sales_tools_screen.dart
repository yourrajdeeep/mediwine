import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SalesToolsScreen extends StatefulWidget {
  const SalesToolsScreen({super.key});

  @override
  State<SalesToolsScreen> createState() => _SalesToolsScreenState();
}

class _SalesToolsScreenState extends State<SalesToolsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController(text: '1');
  String _selectedProduct = 'CardioFlow Plus';
  String _selectedPackage = 'Standard';
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _calculatePrice();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _calculatePrice() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    double basePrice = 0;
    
    switch (_selectedProduct) {
      case 'CardioFlow Plus':
        basePrice = 299.99;
        break;
      case 'NeuroEase Pro':
        basePrice = 249.99;
        break;
      case 'DermaHeal Max':
        basePrice = 199.99;
        break;
    }

    double packageMultiplier = 1.0;
    switch (_selectedPackage) {
      case 'Premium':
        packageMultiplier = 1.2;
        break;
      case 'Standard':
        packageMultiplier = 1.0;
        break;
      case 'Basic':
        packageMultiplier = 0.9;
        break;
    }

    setState(() {
      _totalPrice = basePrice * quantity * packageMultiplier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Order Form',
                  style: GoogleFonts.poppins(),
                ),
              ),
              Tab(
                child: Text(
                  'Follow-ups',
                  style: GoogleFonts.poppins(),
                ),
              ),
              Tab(
                child: Text(
                  'Analytics',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Order Form Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Selection
                        Text(
                          'Product',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedProduct,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          items: [
                            'CardioFlow Plus',
                            'NeuroEase Pro',
                            'DermaHeal Max',
                          ].map((product) {
                            return DropdownMenuItem(
                              value: product,
                              child: Text(product, style: GoogleFonts.poppins()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedProduct = value;
                                _calculatePrice();
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        // Package Selection
                        Text(
                          'Package',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedPackage,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          items: ['Premium', 'Standard', 'Basic'].map((package) {
                            return DropdownMenuItem(
                              value: package,
                              child: Text(package, style: GoogleFonts.poppins()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedPackage = value;
                                _calculatePrice();
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        // Quantity
                        Text(
                          'Quantity',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onChanged: (value) => _calculatePrice(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter quantity';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 32),

                        // Price Summary
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order Summary',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Price',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '\$${_totalPrice.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO: Submit order
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Place Order',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Follow-ups Tab
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: const Icon(Icons.notifications_active_outlined),
                        ),
                        title: Text(
                          'Follow up with Dr. Smith',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Regarding: CardioFlow Plus Sample',
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Due: Tomorrow',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.check_circle_outline),
                          onPressed: () {
                            // TODO: Mark as completed
                          },
                        ),
                      ),
                    ).animate()
                      .fadeIn(delay: (100 * index).ms)
                      .slideX(begin: 0.2);
                  },
                ),

                // Analytics Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAnalyticsCard(
                        context,
                        'Total Orders',
                        '124',
                        Icons.shopping_cart_outlined,
                        Colors.blue,
                        '+12% vs last month',
                      ),
                      const SizedBox(height: 16),
                      _buildAnalyticsCard(
                        context,
                        'Sample Requests',
                        '45',
                        Icons.medical_services_outlined,
                        Colors.green,
                        '+5% vs last month',
                      ),
                      const SizedBox(height: 16),
                      _buildAnalyticsCard(
                        context,
                        'Follow-up Rate',
                        '92%',
                        Icons.track_changes,
                        Colors.orange,
                        '+8% vs last month',
                      ),
                      const SizedBox(height: 16),
                      _buildAnalyticsCard(
                        context,
                        'Conversion Rate',
                        '68%',
                        Icons.trending_up,
                        Colors.purple,
                        '+15% vs last month',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                trend,
                style: GoogleFonts.poppins(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}