import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/doctor_controller.dart';
import '../controllers/visit_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_snackbar.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;
  
  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final doctorController = Get.find<DoctorController>();
    final visitController = Get.find<VisitController>();

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    doctor['name']?.toString() ?? 'Unknown Doctor',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                      ),
                      Center(
                        child: Hero(
                          tag: 'doctor-${doctor['id']?.toString() ?? 'unknown'}',
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: [
                      Tab(child: Text('Profile', style: GoogleFonts.poppins())),
                      Tab(child: Text('History', style: GoogleFonts.poppins())),
                      Tab(child: Text('Notes', style: GoogleFonts.poppins())),
                    ],
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                _buildProfileTab(context),
                _buildHistoryTab(context),
                _buildNotesTab(context, doctorController),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Schedule visit
                    _scheduleVisit(context, visitController);
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text('Schedule Visit', style: GoogleFonts.poppins()),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(AppRoutes.presentation);
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: Text('Present', style: GoogleFonts.poppins()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context) {
    final contact = doctor['contact'] as Map<String, dynamic>? ?? {};
    final preferences = doctor['preferences'] as Map<String, dynamic>? ?? {};
    final preferredProducts = (doctor['preferredProducts'] as List?) ?? [];
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildInfoCard(
          context,
          'Contact Information',
          [
            _buildInfoRow(Icons.email, 'Email', contact['email']?.toString() ?? 'N/A'),
            _buildInfoRow(Icons.phone, 'Phone', contact['phone']?.toString() ?? 'N/A'),
            _buildInfoRow(Icons.location_on, 'Address', contact['address']?.toString() ?? 'N/A'),
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          context,
          'Preferences',
          [
            _buildPreferenceRow(
              'Visit Time',
              doctor['preferredVisitTime']?.toString() ?? 'N/A',
              Icons.access_time,
            ),
            ...preferences.entries.map((entry) => _buildPreferenceRow(
              entry.key,
              '${entry.value}',
              Icons.star,
            )),
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          context,
          'Preferred Products',
          preferredProducts.map<Widget>((product) => ListTile(
            leading: const Icon(Icons.medical_services_outlined),
            title: Text(product?.toString() ?? 'N/A', style: GoogleFonts.poppins()),
          )).toList(),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildHistoryTab(BuildContext context) {
    final visitHistory = (doctor['visitHistory'] as List?) ?? [];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: visitHistory.length,
      itemBuilder: (context, index) {
        final visit = visitHistory[index] as Map<String, dynamic>;
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            title: Text(
              visit['purpose']?.toString() ?? 'N/A',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Date: ${_formatDate(visit['date'] as DateTime? ?? DateTime.now())}',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Outcome',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      visit['outcome']?.toString() ?? 'No outcome recorded',
                      style: GoogleFonts.poppins(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Products Discussed',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ((visit['productsDiscussed'] as List?) ?? [])
                          .map((product) => Chip(
                                label: Text(
                                  product?.toString() ?? 'N/A',
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate()
          .fadeIn(delay: (100 * index).ms)
          .slideX(begin: 0.2);
      },
    );
  }

  Widget _buildNotesTab(BuildContext context, DoctorController controller) {
    final notesController = TextEditingController(text: doctor['notes']?.toString() ?? '');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: notesController,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'Enter notes about the doctor...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final doctorId = doctor['id'] as int? ?? -1;
                controller.updateDoctorNotes(
                  doctorId,
                  notesController.text,
                );
                CustomSnackbar.show(
                  title: 'Success',
                  message: 'Notes updated successfully',
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Notes',
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceRow(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label, style: GoogleFonts.poppins()),
      trailing: Text(value, style: GoogleFonts.poppins()),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _scheduleVisit(BuildContext context, VisitController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ScheduleVisitForm(doctor: doctor),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class ScheduleVisitForm extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const ScheduleVisitForm({
    super.key,
    required this.doctor,
  });

  @override
  State<ScheduleVisitForm> createState() => _ScheduleVisitFormState();
}

class _ScheduleVisitFormState extends State<ScheduleVisitForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _purposeController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _purposeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schedule Visit',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                'Date: ${_formatDate(_selectedDate)}',
                style: GoogleFonts.poppins(),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                'Time: ${_selectedTime.format(context)}',
                style: GoogleFonts.poppins(),
              ),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _purposeController,
              decoration: InputDecoration(
                labelText: 'Purpose',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter visit purpose';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Schedule Visit',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final visitController = Get.find<VisitController>();
      final visitData = {
        'doctorId': widget.doctor['id']?.toString() ?? 'unknown',
        'doctorName': widget.doctor['name']?.toString() ?? 'Unknown Doctor',
        'hospitalName': widget.doctor['hospital']?.toString() ?? 'Unknown Hospital',
        'dateTime': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        'purpose': _purposeController.text,
        'notes': _notesController.text,
      };
      
      visitController.scheduleVisit(visitData);
      Get.back();
      CustomSnackbar.show(
        title: 'Success',
        message: 'Visit scheduled successfully',
      );
    }
  }
}