import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/view_model/home_page_view_model.dart';

import '../view_model/lists_page_view_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      title: const Text(
        "Shopping List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        return value.pageList[value.index];
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        return BottomNavigationBar(
            selectedItemColor: Colors.redAccent,
            selectedIconTheme: const IconThemeData(size: 35),
            selectedFontSize: 16,
            currentIndex: value.index,
            onTap: (deger) {
              value.changeCurrentIndex(deger);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: "Lists"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.store_mall_directory), label: "Shop"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
            ]);
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    ListsPageViewModel viewModel = Provider.of<ListsPageViewModel>(context,listen: false);

    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        if (value.index == 0 && viewModel.lists.isNotEmpty) {
          return FloatingActionButton(
              onPressed: () {
                viewModel.addList(context);
              },
              backgroundColor: Colors.redAccent,
              shape: const CircleBorder(),
              child: const Icon(Icons.add,color: Colors.white,size: 35,));
        }
        else{
          return Container();
        }
      },

    );
  }
}
