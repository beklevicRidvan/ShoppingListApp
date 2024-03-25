import 'package:flutter/material.dart';

import '../model/list_detail_model.dart';
import '../service/sqflite/sqflite_database_service.dart';

class CartPageViewModel with ChangeNotifier{
  final _service = SqfliteDataBaseService();


  List<ListDetailModel> _detailList = [];

  List<ListDetailModel> _detailByListId= [];



  bool _myState = false;



  CartPageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() async{
    _detailList = await _service.getListDetail();
    notifyListeners();
  }

  void getDataByListId(int listId) async{
    _detailByListId = await _service.getListDetailByListId(listId);
    notifyListeners();
  }

  void changeState(bool value){
    _myState = !value;
    notifyListeners();
  }

  void deleteDetailListItem(int index) async{
    var viewModel = _detailList[index];
    int id = await _service.deleteDetailList(viewModel);
    if(id>0 ){
      _detailList.removeAt(index);

    }
    notifyListeners();

  }

  void deleteDetailListItemById(int index)async{
    var viewModel1 = _detailByListId[index];
    int id = await _service.deleteDetailList(viewModel1);
    if(id>0){
      _detailByListId.removeAt(index);


    }
    notifyListeners();


  }



  bool get myState => _myState;
  List<ListDetailModel> get detailList => _detailList;
  List<ListDetailModel> get detailByListId => _detailByListId;


}