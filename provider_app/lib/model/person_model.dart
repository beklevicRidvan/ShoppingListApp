import 'package:flutter/material.dart';

class PersonModel with ChangeNotifier{
  dynamic personId;
  dynamic personName;

  PersonModel({this.personId,this.personName});


  factory PersonModel.withId(int personId){
    return PersonModel(personId: personId);
  }
}