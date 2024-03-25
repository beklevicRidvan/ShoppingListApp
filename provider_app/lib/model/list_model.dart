import 'package:flutter/material.dart';
import 'package:provider_app/model/person_model.dart';

class ListModel with ChangeNotifier {
  dynamic listId;
  String listName;
  String listDate;
  PersonModel personId;
  String importance;
  bool myValue=false;

  int? itemsCount;

  ListModel(
      {required this.listId,
      required this.listName,
      required this.listDate,
      required this.personId,
      required this.importance,
      this.itemsCount});



  void changeValue(bool value){
    myValue= value;
    notifyListeners();
  }

  void changeItemCount(int value){
    itemsCount = value;
    notifyListeners();
  }
}



