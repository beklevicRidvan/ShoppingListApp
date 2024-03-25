import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/view/addToList_page_view.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../service/sqflite/sqflite_database_service.dart';
import 'cart_page_view_model.dart';
import 'lists_page_view_model.dart';

class ProductsPageViewModel with ChangeNotifier {
  final SqfliteDataBaseService _service = SqfliteDataBaseService();

  final CategoryModel categoryModel;

  int _piece = 0;

  int _previousProductIdListLength = 0;
  List<ProductModel> _products = [];

  List<int> _productIdList = [];

  void updateProductIdListLength() {
    if (_previousProductIdListLength != _productIdList.length) {
      // Eğer önceki uzunluk ile şu anki uzunluk farklı ise, değişiklik bildir
      _previousProductIdListLength = _productIdList.length;
      notifyListeners();
    }
  }

  ProductsPageViewModel({required this.categoryModel}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts(categoryModel.categoryId);
    });
  }

  void getProducts(int categoryId) async {
    _products = await _service.getProducts(categoryId);
    notifyListeners();
  }

  void addProducts(
      BuildContext context, int listId, List<int> productMyListID) async {
    await _service.addProductsToList(listId, productMyListID);
    notifyListeners();
  }

  void goToAddPage(BuildContext context, List<int> productIdList) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) {
        return ChangeNotifierProvider(
            create: (context) => ListsPageViewModel(),
            child: ChangeNotifierProvider(
              create: (context) => CartPageViewModel(),
              child: AddToListPageView(
                productIdList: productIdList,
                viewModel: ProductsPageViewModel(categoryModel: categoryModel),
              ),
            ));
      },
    );
    Navigator.push(context, pageRoute);
  }

  int get piece => _piece;
  List<int> get productIdList => _productIdList;

  List<ProductModel> get products => _products;
  int get previousProductIdListLength => _previousProductIdListLength;
}
