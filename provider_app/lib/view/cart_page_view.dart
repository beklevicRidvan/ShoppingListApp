import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/view_model/lists_page_view_model.dart';

import '../model/list_detail_model.dart';
import '../view_model/cart_page_view_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    ListsPageViewModel viewModel = Provider.of(context, listen: false);

    return Consumer<CartPageViewModel>(builder: (context, value, child) {
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: value.detailList.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.lists.length,
                        itemBuilder: (context, index) {
                          var currentIndex = viewModel.lists[index];
                          return GestureDetector(
                            onTap: () {
                              value.getDataByListId(currentIndex.listId);
                              value.changeState(value.myState);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    viewModel.getColor(currentIndex),
                                    viewModel.getColor(currentIndex).withOpacity(0.6),
                                    viewModel.getColor(currentIndex),
                                  ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,

                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer),
                                    BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer),
                                  ]),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                currentIndex.listId.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child:  value.detailByListId.isNotEmpty
                            ? ListView.builder(
                                itemCount: value.myState
                                    ? value.detailByListId.length
                                    : value.detailList.length,
                                itemBuilder: (context, index) {
                                  var currentElement = value.myState
                                      ? value.detailByListId[index]
                                      : value.detailList[index];
                                  return _buildListItem(
                                      context, currentElement, index);
                                })
                            : const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Basket is Empty",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 30),
                                    ),
                                  ],
                                ),
                              )),
                  ],
                )
              : const Center(
                  child: Text("Veriler boş"),
                ));
    });
  }

  Widget _buildListItem(
      BuildContext context, ListDetailModel detail, int index) {
    return Consumer<CartPageViewModel>(
      builder: (context, value, child) {
        return Card(
          child: ListTile(
            leading: Image.asset("assets/placeholder.png"),
            title: Text(detail.productName ?? "Name"),
            subtitle: Text("${detail.price} ₺"),
            trailing: IconButton(
                onPressed: () {
                  if (value.myState) {
                    value.deleteDetailListItemById(index);
                  } else {
                    value.deleteDetailListItem(index);
                  }
                },
                icon: const Icon(
                  CupertinoIcons.clear,
                  color: Colors.red,
                  size: 30,
                )),
          ),
        );
      },
    );
  }
}
