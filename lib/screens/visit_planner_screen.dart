import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/visit_controller.dart';

class VisitPlannerScreen extends StatefulWidget {
  const VisitPlannerScreen({super.key});

  @override
  State<VisitPlannerScreen> createState() => _VisitPlannerScreenState();
}

class _VisitPlannerScreenState extends State<VisitPlannerScreen> {
  final VisitController _visitController = Get.find<VisitController>();
  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Calendar Section
        Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Month Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        final newDate = DateTime(_visitController.selectedDate.value.year, 
                          _visitController.selectedDate.value.month - 1);
                        _visitController.changeSelectedDate(newDate);
                      },
                    ),
                    Obx(() => Text(
                      '${_getMonthName(_visitController.selectedDate.value.month)} ${_visitController.selectedDate.value.year}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        final newDate = DateTime(_visitController.selectedDate.value.year, 
                          _visitController.selectedDate.value.month + 1);
                        _visitController.changeSelectedDate(newDate);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Week Days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _weekDays
                    .map((day) => Text(
                      day,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                    .toList(),
                ),
                const SizedBox(height: 8),
                // Calendar Grid
                Obx(() {
                  final daysInMonth = DateTime(_visitController.selectedDate.value.year, 
                    _visitController.selectedDate.value.month + 1, 0).day;
                  final firstDayOfMonth = DateTime(_visitController.selectedDate.value.year, 
                    _visitController.selectedDate.value.month, 1).weekday - 1;
                    
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: 42,
                    itemBuilder: (context, index) {
                      final adjustedIndex = index - firstDayOfMonth;
                      if (adjustedIndex < 0 || adjustedIndex >= daysInMonth) {
                        return Container();
                      }
                      
                      final day = adjustedIndex + 1;
                      final currentDate = DateTime(_visitController.selectedDate.value.year, 
                        _visitController.selectedDate.value.month, day);
                      final isSelected = day == _visitController.selectedDate.value.day;
                      
                      final hasVisit = _visitController.getVisitsForDate(currentDate).isNotEmpty;

                      return InkWell(
                        onTap: () {
                          _visitController.changeSelectedDate(currentDate);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : hasVisit
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              day.toString(),
                              style: GoogleFonts.poppins(
                                color: isSelected
                                    ? Colors.white
                                    : hasVisit
                                        ? Theme.of(context).primaryColor
                                        : null,
                                fontWeight: isSelected || hasVisit
                                    ? FontWeight.w600
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ).animate().fadeIn().slideY(begin: -0.2),

        // Visits List
        Expanded(
          child: Obx(() {
            final visitsForDate = _visitController.getVisitsForDate(_visitController.selectedDate.value);
            if (_visitController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (visitsForDate.isEmpty) {
              return Center(
                child: Text(
                  'No visits scheduled for this day',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: visitsForDate.length,
              itemBuilder: (context, index) {
                final visit = visitsForDate[index];
                final visitTime = visit['dateTime'] as DateTime;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showVisitDetails(context, visit);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${visitTime.hour.toString().padLeft(2, '0')}:${visitTime.minute.toString().padLeft(2, '0')} - ${visit['doctorName']}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${visit['hospitalName']} - ${(visit['products'] as List).join(', ')}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: visit['status'] == 'scheduled'
                                ? Colors.green
                                : visit['status'] == 'completed'
                                    ? Colors.grey
                                    : Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate()
                  .fadeIn(delay: (100 * index).ms)
                  .slideX(begin: 0.2);
              },
            );
          }),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _showVisitDetails(BuildContext context, Map<String, dynamic> visit) {
    final visitTime = visit['dateTime'] as DateTime;
    final endTime = visitTime.add(Duration(minutes: int.parse(visit['duration'].split(' ')[0]) * 60));
    
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
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.person_outline),
                    ),
                    title: Text('Doctor', style: GoogleFonts.poppins(color: Colors.grey)),
                    subtitle: Text(visit['doctorName'], style: GoogleFonts.poppins()),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.access_time),
                    ),
                    title: Text('Time', style: GoogleFonts.poppins(color: Colors.grey)),
                    subtitle: Text(
                      '${visitTime.hour.toString().padLeft(2, '0')}:${visitTime.minute.toString().padLeft(2, '0')} - '
                      '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                      style: GoogleFonts.poppins()
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.location_on_outlined),
                    ),
                    title: Text('Location', style: GoogleFonts.poppins(color: Colors.grey)),
                    subtitle: Text('${visit['hospitalName']}, ${visit['location']}', 
                      style: GoogleFonts.poppins()),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.medical_services_outlined),
                    ),
                    title: Text('Products', style: GoogleFonts.poppins(color: Colors.grey)),
                    subtitle: Text((visit['products'] as List).join(', '), 
                      style: GoogleFonts.poppins()),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Notes',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.grey[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        visit['notes'],
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final newDate = await showDatePicker(
                              context: context,
                              initialDate: visitTime,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (newDate != null) {
                              await _visitController.rescheduleVisit(visit['id'], newDate);
                              if (context.mounted) Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text('Reschedule', style: GoogleFonts.poppins()),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: visit['status'] != 'completed' ? () {
                            // TODO: Navigate to presentation screen
                            Navigator.pop(context);
                          } : null,
                          icon: const Icon(Icons.play_arrow),
                          label: Text(
                            visit['status'] == 'completed' ? 'Completed' : 'Start',
                            style: GoogleFonts.poppins()
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
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