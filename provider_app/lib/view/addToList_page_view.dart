import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/list_model.dart';
import 'package:provider_app/view_model/products_page_view_model.dart';

import '../view_model/lists_page_view_model.dart';

class AddToListPageView extends StatelessWidget {
  const AddToListPageView(
      {super.key, required this.productIdList, required this.viewModel});
  final List<int> productIdList;
  final ProductsPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade100,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text("All Shopping Lists"),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<ListsPageViewModel>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.lists.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: value.lists.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: value.lists[index],
                          child: _buildListItem(),
                        );
                      },
                    ),
                  )
                : GestureDetector(
                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                      subtitle: Text("Create New"),
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                elevation: 15,
                shadowColor: Colors.red.shade200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.white10),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red, fontSize: 25),
            )),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                elevation: 15,
                shadowColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.red.shade500),
            child: const Text(
              "Back to shopping",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
      ],
    );
  }

  _buildListItem() {
    return Consumer<ListModel>(
      builder: (context, value, child) {
        return ListTile(
          leading: Checkbox(
              value: value.myValue,
              onChanged: (myChangeValue) {
                value.changeValue(myChangeValue!);
              }),
          title: Text(value.listName),
          trailing: IconButton(
              onPressed: () {
                if (value.myValue) {
                  if (productIdList.isNotEmpty) {
                    viewModel.addProducts(context, value.listId, productIdList);
                    value.changeItemCount(value.itemsCount!);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Basket is Empty",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              _buildButtons(context),
                            ],
                          );
                        });
                  }
                }
              },
              icon: const Icon(Icons.add)),
        );
      },
    );
  }
}
