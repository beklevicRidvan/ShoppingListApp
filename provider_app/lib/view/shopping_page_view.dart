import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/category_model.dart';

import '../view_model/shop_page_view_model.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<ShopPageViewModel>(builder: (context, viewModel, child) {
      if(viewModel.categories.isNotEmpty){
        return  Column(
          children: [

         Stack(

           children: [
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                 child: SizedBox(
                   height: 300,
                   child: PageView.builder(physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),controller: viewModel.pageController,itemCount: viewModel.imagePaths.length,itemBuilder: (context, index) {
                     return Image.asset(viewModel.imagePaths[index],fit: BoxFit.contain,);
                   },),
                 ),
               ),
             ),
             Positioned(left: 0,top: 0,bottom: 0,child: IconButton(onPressed: (){

                
                 viewModel.changeImage(viewModel.currentImageIndex-1);

             }, icon: const Icon(Icons.chevron_left,size: 50,color: Colors.white,))),
             Positioned(right: 0,top: 0,bottom: 0,child: IconButton(onPressed: (){

                 viewModel.changeImage(viewModel.currentImageIndex+1);


             }, icon: const Icon(Icons.chevron_right,size: 50,color: Colors.white,)))


           ]
         ),

         Expanded(
           child: Padding(
                   padding: const EdgeInsets.all(16.0),
                 child: GridView.builder(
                 itemCount: viewModel.categories.length,
                 gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                 mainAxisExtent: deviceHeight*0.25,
                 crossAxisSpacing: deviceHeight*0.02,
                 mainAxisSpacing: deviceHeight/100,
                 crossAxisCount: 3),
                 itemBuilder: (BuildContext context, int index) {
                 return ChangeNotifierProvider.value(
                 value: viewModel.categories[index],
                 child: _buildListItem(index,context),
                 );
                 }),
                 ),
         ),
          ],
        );
      }
      else{
        return const Center(child: CircularProgressIndicator(color: Colors.redAccent,),);
      }
    });
  }

  _buildListItem(int index,BuildContext context) {
    ShopPageViewModel viewModel = Provider.of<ShopPageViewModel>(context,listen: false);

    return Consumer<CategoryModel>(builder: (context, category, child) {
      return GestureDetector(
        onTap: (){
          viewModel.goProductsPage(context, category);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/${category.categoryImage}",fit: BoxFit.contain,),
            ),
            Text(
              category.categoryName.length >= 13 ? "${category.categoryName.substring(0,11)}.." : category.categoryName,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700,fontSize: 15),
            ),
          ],
        ),
      );
    });
  }
}
