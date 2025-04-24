import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  context,
                  'Target Achievement',
                  '85%',
                  Icons.track_changes,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  context,
                  'Doctor Visits',
                  '120',
                  Icons.people_outline,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  context,
                  'Products Pitched',
                  '45',
                  Icons.medical_services_outlined,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  context,
                  'Conversion Rate',
                  '62%',
                  Icons.trending_up,
                  Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Doctor Engagement Section
          Text(
            'Doctor Engagement',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildEngagementBar(context, 'Dr. Abhijit Banerjee', 95),
                  _buildEngagementBar(context, 'Dr. Bidhan Sarkar', 88),
                  _buildEngagementBar(context, 'Dr. Rajdeep Dey', 76),
                  _buildEngagementBar(context, 'Dr. Soumik Hazra', 72),
                  _buildEngagementBar(context, 'Dr. Debasish Baidya', 65),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Product Performance Section
          Text(
            'Product Performance',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProductPerformanceItem(
                    context,
                    'CardioFlow Plus',
                    2500,
                    3000,
                    Colors.green,
                  ),
                  _buildProductPerformanceItem(
                    context,
                    'NeuroEase Pro',
                    1800,
                    2000,
                    Colors.orange,
                  ),
                  _buildProductPerformanceItem(
                    context,
                    'DermaHeal Max',
                    1200,
                    1500,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Visit Trends Section
          Text(
            'Visit Trends',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'This Week',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '24 Visits',
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDayVisit(context, 'Mon', 5, true),
                      _buildDayVisit(context, 'Tue', 4, true),
                      _buildDayVisit(context, 'Wed', 6, true),
                      _buildDayVisit(context, 'Thu', 3, true),
                      _buildDayVisit(context, 'Fri', 6, false),
                      _buildDayVisit(context, 'Sat', 0, false),
                      _buildDayVisit(context, 'Sun', 0, false),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.2),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
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
            Icon(icon, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementBar(BuildContext context, String name, int percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: GoogleFonts.poppins()),
              Text('$percentage%', 
                style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductPerformanceItem(
    BuildContext context,
    String name,
    int achieved,
    int target,
    Color color,
  ) {
    final percentage = (achieved / target * 100).round();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: GoogleFonts.poppins()),
              Text('$achieved/$target', 
                style: GoogleFonts.poppins(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: achieved / target,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayVisit(BuildContext context, String day, int visits, bool past) {
    return Column(
      children: [
        Text(
          day,
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 24,
          height: 60,
          decoration: BoxDecoration(
            color: past
                ? Theme.of(context).primaryColor.withOpacity(visits / 10)
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          visits.toString(),
          style: GoogleFonts.poppins(
            color: past ? Colors.black87 : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}