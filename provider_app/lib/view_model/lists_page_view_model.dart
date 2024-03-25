import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/list_model.dart';
import '../model/person_model.dart';
import '../service/sqflite/sqflite_database_service.dart';
import '../view/create_list_page_view.dart';
import 'created_list_page_view_model.dart';

class ListsPageViewModel with ChangeNotifier {
  final _service = SqfliteDataBaseService();

  List<ListModel> _lists = [];

  List<ListModel> get lists => _lists;

  ListsPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLists();
    });
  }

  void getLists() async {
    _lists = await _service.getMyLists();
    notifyListeners();
  }



  Future<List<dynamic>?> goCreateListPage(BuildContext context) async {
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(
        create: (context) => CreatedListPageViewModel(),
        child: const CreatedListPage(),
      );
    });
    final result = await Navigator.push(context, pageRoute);

    return result as List<dynamic>?;
  }

  void addList(BuildContext context) async {
    List<dynamic>? myLists = await goCreateListPage(context);

    if (myLists != null && myLists.isNotEmpty) {
      String name = myLists[0];
      String date = myLists[1];
      String priority = myLists[3];
      int id = await _service.addShoppingListItem(name, date, 1, priority);
      _lists.add(ListModel(
          listId: id,
          listName: name,
          listDate: date,
          personId: PersonModel.withId(1),
          importance: priority,
        itemsCount: 0,
      ));
    }
    notifyListeners();

  }

  void deleteList(int index) async{
    ListModel listModel = _lists[index];

    int id = await _service.deleteList(listModel);
    if(id>0){
      _lists.removeAt(index);
    }
    notifyListeners();

  }


  Color getColor(ListModel list) {
    if(list.importance == "High"){
      return const Color(0xff6190f9);
    }
    else if(list.importance  == "Medium"){
      return const Color(0xff15ccb9);

    }
    else{
      return const Color(0xfffebf78);
    }
  }


}
