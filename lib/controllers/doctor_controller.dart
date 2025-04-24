import 'package:get/get.dart';

class DoctorController extends GetxController {
  final RxList<Map<String, dynamic>> doctors = <Map<String, dynamic>>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDoctors();
  }

  Future<void> loadDoctors() async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final doctorData = [
      {
        'name': 'Dr. Abhijit Chatterjee',
        'specialty': 'Cardiologist',
        'hospital': 'Apollo Hospitals, Kolkata',
      },
      {
        'name': 'Dr. Sarah Williams',
        'specialty': 'Neurologist',
        'hospital': 'Columbia Asia Hospital',
      },
      {
        'name': 'Dr. Rajesh Banerjee',
        'specialty': 'Dermatologist',
        'hospital': 'AMRI Hospital, Salt Lake',
      },
      {
        'name': 'Dr. Suchitra Sen',
        'specialty': 'Cardiologist',
        'hospital': 'Fortis Hospital, Anandapur',
      },
      {
        'name': 'Dr. Michael Chen',
        'specialty': 'Neurologist',
        'hospital': 'Medica Superspecialty Hospital',
      },
      {
        'name': 'Dr. Anindita Roy',
        'specialty': 'Dermatologist',
        'hospital': 'Ruby General Hospital',
      },
      {
        'name': 'Dr. Debashish Ghosh',
        'specialty': 'Cardiologist',
        'hospital': 'BM Birla Heart Research Centre',
      },
      {
        'name': 'Dr. Amanda Parker',
        'specialty': 'Neurologist',
        'hospital': 'Institute of Neurosciences',
      },
      {
        'name': 'Dr. Soumitra Mukherjee',
        'specialty': 'Dermatologist',
        'hospital': 'SSKM Hospital',
      },
      {
        'name': 'Dr. Priya Dasgupta',
        'specialty': 'Cardiologist',
        'hospital': 'Rabindranath Tagore Hospital',
      },
      {
        'name': 'Dr. Robert Wilson',
        'specialty': 'Neurologist',
        'hospital': 'Peerless Hospital',
      },
      {
        'name': 'Dr. Subhash Bose',
        'specialty': 'Dermatologist',
        'hospital': 'Woodlands Multispeciality Hospital',
      },
      {
        'name': 'Dr. Mitali Sen',
        'specialty': 'Cardiologist',
        'hospital': 'Calcutta Medical Research Institute',
      },
      {
        'name': 'Dr. David Miller',
        'specialty': 'Neurologist',
        'hospital': 'Belle Vue Clinic',
      },
      {
        'name': 'Dr. Arjun Chakraborty',
        'specialty': 'Dermatologist',
        'hospital': 'Desun Hospital',
      }
    ];
    
    doctors.value = List.generate(
      doctorData.length,
      (index) => {
        'id': index + 1,
        'name': doctorData[index]['name'],
        'specialty': doctorData[index]['specialty'],
        'hospital': doctorData[index]['hospital'],
        'lastVisit': DateTime.now().subtract(Duration(days: index * 2)),
        'rating': 4.5,
        'visitCount': 10 - (index % 5),
        'preferredVisitTime': 'Morning',
        'preferredProducts': [
          'CardioFlow Plus',
          'NeuroEase Pro',
        ],
        'preferences': {
          'Product Presentations': 4.5,
          'Research Papers': 4.0,
          'Clinical Trials': 3.5,
        },
        'notes': 'Interested in new medical developments.',
        'contact': {
          'email': '${doctorData[index]['name']?.toString().toLowerCase().replaceAll(' ', '.')}@${doctorData[index]['hospital']?.toString().toLowerCase().replaceAll(' ', '')}.com',
          'phone': '+91 ${9800000001 + index}',
          'address': doctorData[index]['hospital'],
        },
        'visitHistory': List.generate(
          3,
          (visitIndex) => {
            'date': DateTime.now().subtract(Duration(days: visitIndex * 30)),
            'purpose': 'Product Presentation',
            'outcome': 'Positive response to product demonstration',
            'productsDiscussed': ['CardioFlow Plus', 'NeuroEase Pro'],
            'followUpNeeded': true,
          },
        ),
      },
    );

    isLoading.value = false;
  }

  List<Map<String, dynamic>> get filteredDoctors {
    return doctors.where((doctor) {
      final query = searchQuery.value.toLowerCase();
      return query.isEmpty ||
          doctor['name'].toLowerCase().contains(query) ||
          doctor['specialty'].toLowerCase().contains(query) ||
          doctor['hospital'].toLowerCase().contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<Map<String, dynamic>> getDoctorsBySpecialty(String specialty) {
    return doctors
        .where((doctor) => doctor['specialty'] == specialty)
        .toList();
  }

  Future<void> updateDoctorPreferences(
    int doctorId, 
    Map<String, dynamic> preferences,
  ) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = doctors.indexWhere((doctor) => doctor['id'] == doctorId);
    if (index != -1) {
      final updatedDoctor = Map<String, dynamic>.from(doctors[index]);
      updatedDoctor['preferences'] = preferences;
      doctors[index] = updatedDoctor;
    }
    
    isLoading.value = false;
  }

  Future<void> addNewDoctor(Map<String, dynamic> doctorData) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    doctors.add({
      'id': doctors.length + 1,
      ...doctorData,
      'visitHistory': [],
      'visitCount': 0,
    });
    
    isLoading.value = false;
  }

  Future<void> updateDoctorNotes(int doctorId, String notes) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = doctors.indexWhere((doctor) => doctor['id'] == doctorId);
    if (index != -1) {
      final updatedDoctor = Map<String, dynamic>.from(doctors[index]);
      updatedDoctor['notes'] = notes;
      doctors[index] = updatedDoctor;
    }
    
    isLoading.value = false;
  }

  Future<void> addVisitRecord(
    int doctorId, 
    Map<String, dynamic> visitData,
  ) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = doctors.indexWhere((doctor) => doctor['id'] == doctorId);
    if (index != -1) {
      final updatedDoctor = Map<String, dynamic>.from(doctors[index]);
      final visitHistory = List<Map<String, dynamic>>.from(
        updatedDoctor['visitHistory'],
      );
      visitHistory.insert(0, {
        'date': DateTime.now(),
        ...visitData,
      });
      updatedDoctor['visitHistory'] = visitHistory;
      updatedDoctor['visitCount'] = (updatedDoctor['visitCount'] as int) + 1;
      updatedDoctor['lastVisit'] = DateTime.now();
      doctors[index] = updatedDoctor;
    }
    
    isLoading.value = false;
  }

  List<Map<String, dynamic>> get topDoctors {
    return List<Map<String, dynamic>>.from(doctors)
      ..sort((a, b) => (b['visitCount'] as int).compareTo(a['visitCount'] as int))
      ..take(5);
  }

  List<Map<String, dynamic>> get recentlyVisitedDoctors {
    return List<Map<String, dynamic>>.from(doctors)
      ..sort((a, b) => (b['lastVisit'] as DateTime)
          .compareTo(a['lastVisit'] as DateTime))
      ..take(5);
  }
}