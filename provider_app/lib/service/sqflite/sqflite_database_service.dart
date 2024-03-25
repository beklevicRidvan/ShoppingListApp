import '../../model/category_model.dart';
import '../../model/list_detail_model.dart';
import '../../model/list_model.dart';
import '../../model/person_model.dart';
import '../../model/product_model.dart';
import '../database_service.dart';

class SqfliteDataBaseService {
  Future<List<CategoryModel>> getCategories() async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db.query("categories");

    return List<CategoryModel>.generate(maps.length, (index) {
      var row = maps[index];
      return CategoryModel(
          categoryId: row["categoryId"],
          categoryName: row["categoryName"],
          categoryImage: row["categoryImage"]);
    });
  }

  Future<List<ProductModel>> getProducts(int categoryId) async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db
        .query("products", where: "categoryId= ?", whereArgs: [categoryId]);

    return List<ProductModel>.generate(maps.length, (index) {
      var row = maps[index];
      return ProductModel(
          productId: row["productId"],
          productName: row["productName"],
          categoryId: CategoryModel.withId(row["categoryId"]),
          price: row["price"]);
    });
  }

  Future<List<ListModel>> getMyLists() async {
    final  db = await DatabaseHelper.getDataBase();

     List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      l.*,
      COUNT(ld.productId) AS productCount
    FROM 
      lists AS l
    LEFT JOIN 
      listdetail AS ld 
    ON 
      l.listId = ld.listId
    GROUP BY 
      l.listId
  ''');

    // Veritabanından gelen sonuçları ListModel nesnelerine dönüştürmek
     List<ListModel> lists = result.map((map) {
      return ListModel(
          listId: map['listId'],
          listName: map['listName'],
          listDate: map['listDate'],
          personId: PersonModel.withId(map["personId"]),
          importance: map['importance'],
          itemsCount: map['productCount'] // Veritabanından gelen ürün sayısını itemsCount alanına ata
      );
    }).toList();

    return lists;
  }


  
  
  Future<int> deleteList(ListModel listModel) async{
    var db = await DatabaseHelper.getDataBase();
    // Önce listdetail tablosundan ilgili listId'ye sahip kayıtları sil
    await db.delete('listdetail', where: 'listId = ?', whereArgs: [listModel.listId]);
    return await db.delete("lists",where: "listId= ?",whereArgs: [listModel.listId]);
  }

  Future<int> addShoppingListItem(
      String listName, String listDate, int personId, String importance) async {
    var db = await DatabaseHelper.getDataBase();

    Map<String, dynamic> newList = {};

    newList["listName"] = listName;
    newList["listDate"] = listDate;
    newList["personId"] = personId;
    newList["importance"] = importance;

    return await db.insert("lists", newList);
  }

  Future<void> addProductsToList(int listId, List<int> productIds) async {
    var db = await DatabaseHelper.getDataBase();
    for (var productId in productIds) {
      String sql = "INSERT INTO listdetail (listId, productId) VALUES (?, ?)";
      List<dynamic> args = [listId, productId];

      await db.rawQuery(sql, args);
    }
  }

  Future<List<ListDetailModel>> getListDetail() async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT p.productName, p.price , ld.detailId,ld.listId,ld.productId FROM products p JOIN listdetail ld ON p.productId = ld.productId");

    return List<ListDetailModel>.generate(maps.length, (index) {
      var row = maps[index];
      return ListDetailModel(
          detailId: row["detailId"],
          listId: row["listId"],
          productId: row["productId"],
          productName: row["productName"],
          price: row["price"]);
    });
  }

  Future<List<ListDetailModel>> getListDetailByListId(int listId) async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT p.productName, p.price , ld.detailId,ld.listId,ld.productId FROM products p JOIN listdetail ld ON p.productId = ld.productId where listId= $listId");

    return List<ListDetailModel>.generate(maps.length, (index) {
      var row = maps[index];
      return ListDetailModel(
          detailId: row["detailId"],
          listId: row["listId"],
          productId: row["productId"],
          productName: row["productName"],
          price: row["price"]);
    });
  }
  
  
  
  Future<int> deleteDetailList(ListDetailModel listDetailModel) async{
    var db = await DatabaseHelper.getDataBase();

    return await db.delete("listdetail",where: "detailId= ?",whereArgs: [listDetailModel.detailId]);
  }
}
