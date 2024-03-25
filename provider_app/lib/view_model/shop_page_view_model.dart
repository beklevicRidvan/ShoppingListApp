import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/view_model/lists_page_view_model.dart';
import 'package:provider_app/view_model/products_page_view_model.dart';

import '../model/category_model.dart';
import '../service/sqflite/sqflite_database_service.dart';
import '../view/products_page_view.dart';

class ShopPageViewModel with ChangeNotifier {
  final _service = SqfliteDataBaseService();

  late PageController _pageController;

  int _currentImageIndex = 0;

  List<CategoryModel> _categories = [];

  final List<String> _imagePaths = [
    "assets/manav.png",
    "assets/discounts.png",
    "assets/snacks.png",
    "assets/electronic.png"
  ];



  ShopPageViewModel() {
    _pageController = PageController(initialPage: _currentImageIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategories();
    });
  }

  void getCategories() async {
    _categories = await _service.getCategories();
    notifyListeners();
  }

  void changeImage(int newIndex) {
    if (newIndex >= 0 && newIndex < _imagePaths.length) {
      _currentImageIndex = newIndex;
      pageController.animateToPage(
        _currentImageIndex,
        duration: const Duration(milliseconds: 300), // Opsiyonel: Animasyon süresi
        curve: Curves.easeInOut, // Opsiyonel: Animasyon eğrisi
      );
      notifyListeners();
    }
  }

  void goProductsPage(BuildContext context, CategoryModel categoryModel) {
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(
        create: (context) => ProductsPageViewModel(
          categoryModel: categoryModel,
        ),
        child:  ProductsPage()
      );
    });
    Navigator.push(context, pageRoute);
  }

  set currentImageIndex(int value) {
    _currentImageIndex = value;
  }

  List<String> get imagePaths => _imagePaths;
  PageController get pageController => _pageController;
  int get currentImageIndex => _currentImageIndex;
  List<CategoryModel> get categories => _categories;
}
