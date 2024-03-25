import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/cart_page_view.dart';
import '../view/lists_page_view.dart';
import '../view/shopping_page_view.dart';
import 'lists_page_view_model.dart';

class HomePageViewModel with ChangeNotifier{
  int _index=0;

  int get index => _index;

  set index(int value) {
    _index = value;
  }

  late ListsPage _listsPage;
  late ShoppingPage _shoppingPage;
  late CartPage _cartPage;
  late List<AppBar> appBarList;
  late List<Widget> _pageList;


  List<Widget> get pageList => _pageList;

  HomePageViewModel(){
    _listsPage = const ListsPage();
    _shoppingPage = const ShoppingPage();
    _cartPage = const CartPage();
    _pageList= [_listsPage,_shoppingPage,_cartPage];
  }


  void changeCurrentIndex(int value){
    _index = value;
    notifyListeners();
  }






}