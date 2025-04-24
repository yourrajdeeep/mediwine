import 'package:get/get.dart';

class ProductController extends GetxController {
  final List<String> categories = [
    'All',
    'Cardiology',
    'Neurology',
    'Dermatology',
    'Orthopedics',
    'Gastroenterology',
  ];
  
  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isListView = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    final cardiologyProducts = [
      {
        'name': 'Metoprolol',
        'description': 'Beta-blocker used to treat high blood pressure and heart failure.',
        'imagePath': 'assets/images/product1.jpg',
      },
      {
        'name': 'Amlodipine',
        'description': 'Calcium channel blocker for treating hypertension and angina.',
        'imagePath': 'assets/images/product2.jpg',
      },
      {
        'name': 'Lisinopril',
        'description': 'ACE inhibitor for treating hypertension and heart failure.',
        'imagePath': 'assets/images/product3.jpg',
      },
      {
        'name': 'Clopidogrel',
        'description': 'Antiplatelet medication to prevent heart attacks and strokes.',
        'imagePath': 'assets/images/product4.jpg',
      },
      {
        'name': 'Digoxin',
        'description': 'Cardiac glycoside used to treat heart failure and atrial fibrillation.',
        'imagePath': 'assets/images/product5.jpg',
      }
    ];

    final neurologyProducts = [
      {
        'name': 'Levetiracetam',
        'description': 'Antiepileptic drug used to treat seizures.',
        'imagePath': 'assets/images/product6.jpeg',
      },
      {
        'name': 'Memantine',
        'description': "NMDA receptor antagonist used in Alzheimer's disease treatment.",
        'imagePath': 'assets/images/product7.jpg',
      },
      {
        'name': 'Sumatriptan',
        'description': 'Selective serotonin receptor agonist for migraine treatment.',
        'imagePath': 'assets/images/product8.jpg',
      },
      {
        'name': 'Pregabalin',
        'description': 'Anticonvulsant used for neuropathic pain and epilepsy.',
        'imagePath': 'assets/images/product9.jpg',
      },
      {
        'name': 'Donepezil',
        'description': "Acetylcholinesterase inhibitor for Alzheimer's disease treatment.",
        'imagePath': 'assets/images/product10.jpg',
      }
    ];

    products.value = List.generate(
      10,
      (index) {
        final isCardiology = index % 2 == 0;
        final productsList = isCardiology ? cardiologyProducts : neurologyProducts;
        final productIndex = (index ~/ 2) % productsList.length;
        final product = productsList[productIndex];
        
        return {
          'id': index + 1,
          'name': product['name'],
          'category': isCardiology ? 'Cardiology' : 'Neurology',
          'rating': 4.5,
          'description': product['description'],
          'imagePath': product['imagePath'],
          'features': [
            'Clinically proven efficacy',
            'Well-tolerated safety profile',
            'Available in multiple dosage forms',
          ],
          'clinicalTrials': List.generate(
            3,
            (trialIndex) => {
              'title': 'Clinical Trial ${trialIndex + 1}',
              'journal': 'Medical Journal ${2025 - trialIndex}',
              'results': 'Significant improvement observed in patient outcomes...',
            },
          ),
        };
      },
    );

    isLoading.value = false;
  }

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory.value == 'All' ||
          product['category'] == selectedCategory.value;
      
      final matchesSearch = searchQuery.value.isEmpty ||
          product['name'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          product['category'].toLowerCase().contains(searchQuery.value.toLowerCase());
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void toggleViewMode() {
    isListView.value = !isListView.value;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}