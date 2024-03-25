import 'package:flutter/material.dart';

class CategoryModel with ChangeNotifier {
  dynamic categoryId;
  dynamic categoryName;
  dynamic categoryImage;

  CategoryModel(
      {this.categoryId,
       this.categoryName,
       this.categoryImage});

  Map<String, dynamic> toMap() {
    return {
      "categoryId": categoryId,
      "categoryName": categoryName,
      "categoryImage": categoryImage
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        categoryId: map["categoryId"],
        categoryName: map["categoryName"],
        categoryImage: map["categoryImage"]);
  }


  factory CategoryModel.withId(int categoryId){
    return CategoryModel(categoryId: categoryId);
  }
}
