import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';





class DatabaseHelper {
  static const String databaseName = "shopping.sqlite";
  static Future<Database> getDataBase() async {
    String veritabaniYolu = join(await getDatabasesPath(),databaseName);
    if(await databaseExists(veritabaniYolu)){
    }else{
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);
    }
    return openDatabase(veritabaniYolu);
  }





}