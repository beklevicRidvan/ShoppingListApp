import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/product_model.dart';
import 'package:provider_app/view_model/lists_page_view_model.dart';

import '../tools/constants.dart';
import '../view_model/products_page_view_model.dart';

class ProductsPage extends StatelessWidget {
   ProductsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          _buildSliverBody(context),
          _buildSlivertoBoxAdapter(context),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    ProductsPageViewModel viewModel =
        Provider.of<ProductsPageViewModel>(context, listen: false);
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      floating: true,
      pinned: true,
      expandedHeight: 300,
      backgroundColor: Colors.red.shade200,
      snap: true,
      actions: [
        Consumer<ProductsPageViewModel>(
          builder: (context, value, child) {
            return Stack(
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(width: 60),
                Positioned(
                    top: 0,
                    right: 10,
                    child: value.previousProductIdListLength > 0
                        ? CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.redAccent,
                            child: Text(
                              value.productIdList.length.toString(),
                              style: Constants.getListCardTextStyle(15),
                            ),
                          )
                        : Container()),
              ],
            );
          },
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(viewModel.categoryModel.categoryName),
        background:
            Image.asset("assets/${viewModel.categoryModel.categoryImage}"),
      ),
    );
  }

  Widget _buildSliverBody(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<ProductsPageViewModel>(
        builder: (context, viewModel, child) {
      return SliverGrid(
          delegate: SliverChildBuilderDelegate(
              childCount: viewModel.products.length,
              (context, index) => ChangeNotifierProvider.value(
                    value: viewModel.products[index],
                    child: _buildListItem(context, index),
                  )),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: deviceHeight * 0.35,
              crossAxisSpacing: deviceHeight * 0.02,
              mainAxisSpacing: deviceHeight / 100,
              crossAxisCount: 2));
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    ProductsPageViewModel viewModel =
    Provider.of<ProductsPageViewModel>(context, listen: false);
    return Consumer<ProductModel>(builder: (context, product, child) {
      return Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  "assets/placeholder.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "₺${product.price.toInt()}",
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(product.productName),
            ],
          ),
          Consumer<ProductsPageViewModel>(
            builder: (context, value, child) {
              return Positioned(
                  right: 0,
                  top: 0,
                  child: product.productPiece == 0
                      ? ElevatedButton(
                          onPressed: () {
                            product.addBasket(value.productIdList);
                            viewModel.updateProductIdListLength();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(0),
                              backgroundColor: Colors.red.withOpacity(0.8)),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ))
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  product.addBasket(value.productIdList);
                                  viewModel.updateProductIdListLength();


                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor:
                                        Colors.red.withOpacity(0.8)),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            Text(product.productPiece.toString()),
                            ElevatedButton(
                                onPressed: () {
                                  product.deleteBasket(value.productIdList);
                                  viewModel.updateProductIdListLength();

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor:
                                        Colors.red.withOpacity(0.8)),
                                child: const Icon(
                                  CupertinoIcons.minus,
                                  size: 30,
                                  color: Colors.white,
                                ))
                          ],
                        ));
            },
          )
        ],
      );
    });
  }

  _buildSlivertoBoxAdapter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        color: Colors.blue,
        child: Consumer<ProductsPageViewModel>(builder: (context, viewModel, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: const RoundedRectangleBorder()),
            onPressed: () {
              print(viewModel.productIdList);
              viewModel.goToAddPage(context,viewModel.productIdList);

            },
            child: Text(
              'Add List',
              style: Constants.getListCardTextStyle(30),
            ),
          );
        },)
      ),
    );
  }
}
