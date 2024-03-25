import 'package:flutter/material.dart';


class ListDetailModel with ChangeNotifier{

  int detailId;
  int listId;
  int productId;
  String? productName;
  double?  price;

  ListDetailModel({required this.detailId,required this.listId,required this.productId,this.productName,this.price});








}