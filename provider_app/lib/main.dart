import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/home_page_view.dart';
import 'view_model/cart_page_view_model.dart';
import 'view_model/home_page_view_model.dart';
import 'view_model/lists_page_view_model.dart';
import 'view_model/shop_page_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => HomePageViewModel()),
        ChangeNotifierProvider(create: (context)=> ListsPageViewModel()),
        ChangeNotifierProvider(create: (context)=> ShopPageViewModel()),
        ChangeNotifierProvider(create: (context) => CartPageViewModel(),),

      ], child: const MyHomePage()),
    );
  }
}
