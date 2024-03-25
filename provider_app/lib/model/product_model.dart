import 'package:flutter/cupertino.dart';

import 'category_model.dart';

class ProductModel with ChangeNotifier{
  dynamic productId;
  String productName;
  CategoryModel categoryId;
  double price;
  int productPiece;
  final valueNotifier = ValueNotifier<int>(0);

  ProductModel(
      {this.productId,
      required this.productName,
      required this.categoryId,
      required this.price,this.productPiece =0});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        productId: map["productId"],
        productName: map["productName"],
        categoryId: map["categoryId"],
        price: map["price"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "productName": productName,
      "categoryId": categoryId,
      "price": price,
    };
  }


  void addBasket(List<int> productIdLists){
    ++productPiece;
      productIdLists.add(productId);
    print(productIdLists);

    notifyListeners();

  }

  void deleteBasket(List<int> productIdLists){
    --productPiece;
    if(productIdLists.contains(productId)){


        productIdLists.remove(productId);

      print(productIdLists);
      notifyListeners();

    }

  }

}
