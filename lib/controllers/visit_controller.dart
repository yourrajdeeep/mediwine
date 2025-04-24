import 'package:get/get.dart';

class VisitController extends GetxController {
  final RxList<Map<String, dynamic>> visits = <Map<String, dynamic>>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadVisits();
  }

  Future<void> loadVisits() async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final doctorNames = [
      'Dr. Abhijit Chatterjee',
      'Dr. Sarah Williams',
      'Dr. Debashish Banerjee',
      'Dr. Michael Chen',
      'Dr. Suchitra Mukherjee',
      'Dr. Rajesh Khanna',
      'Dr. Priya Dasgupta',
      'Dr. James Anderson',
      'Dr. Soumitra Bhattacharya',
      'Dr. Elena Rodriguez'
    ];
    
    visits.value = List.generate(
      10,
      (index) => {
        'id': index + 1,
        'doctorName': doctorNames[index],
        'hospitalName': 'City Hospital',
        'dateTime': DateTime.now().add(Duration(days: index)),
        'status': index == 0 ? 'scheduled' : index == 1 ? 'completed' : 'pending',
        'products': ['CardioFlow Plus', 'NeuroEase Pro'],
        'notes': 'Discuss the latest clinical trials for CardioFlow Plus.',
        'location': 'Room 305',
        'duration': '1 hour',
      },
    );

    isLoading.value = false;
  }

  List<Map<String, dynamic>> getVisitsForDate(DateTime date) {
    return visits.where((visit) {
      final visitDate = visit['dateTime'] as DateTime;
      return visitDate.year == date.year &&
          visitDate.month == date.month &&
          visitDate.day == date.day;
    }).toList();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> scheduleVisit(Map<String, dynamic> visitData) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    visits.add({
      'id': visits.length + 1,
      ...visitData,
      'status': 'scheduled',
    });
    
    isLoading.value = false;
  }

  Future<void> rescheduleVisit(int visitId, DateTime newDateTime) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = visits.indexWhere((visit) => visit['id'] == visitId);
    if (index != -1) {
      final updatedVisit = Map<String, dynamic>.from(visits[index]);
      updatedVisit['dateTime'] = newDateTime;
      visits[index] = updatedVisit;
    }
    
    isLoading.value = false;
  }

  Future<void> cancelVisit(int visitId) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    visits.removeWhere((visit) => visit['id'] == visitId);
    
    isLoading.value = false;
  }

  Future<void> completeVisit(int visitId, String notes) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = visits.indexWhere((visit) => visit['id'] == visitId);
    if (index != -1) {
      final updatedVisit = Map<String, dynamic>.from(visits[index]);
      updatedVisit['status'] = 'completed';
      updatedVisit['notes'] = notes;
      visits[index] = updatedVisit;
    }
    
    isLoading.value = false;
  }

  List<Map<String, dynamic>> get upcomingVisits {
    final now = DateTime.now();
    return visits
        .where((visit) => 
            visit['dateTime'].isAfter(now) && 
            visit['status'] == 'scheduled')
        .toList()
      ..sort((a, b) => 
          (a['dateTime'] as DateTime).compareTo(b['dateTime'] as DateTime));
  }

  List<Map<String, dynamic>> get completedVisits {
    return visits
        .where((visit) => visit['status'] == 'completed')
        .toList()
      ..sort((a, b) => 
          (b['dateTime'] as DateTime).compareTo(a['dateTime'] as DateTime));
  }
}