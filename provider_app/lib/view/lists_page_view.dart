import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/list_model.dart';

import '../tools/constants.dart';
import '../view_model/lists_page_view_model.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<ListsPageViewModel>(builder: (context,viewModel,child){
      if(viewModel.lists.isNotEmpty){
        return ListView.builder(itemCount: viewModel.lists.length,itemBuilder: (BuildContext context,int index){
          return ChangeNotifierProvider.value(value: viewModel.lists[index],child: _buildListItem(context,index),);
        });
      }
      else{
        return _buildListIsEmptyChild(context);
      }
    });
  }



  Widget _buildListIsEmptyChild(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Icon(
            Icons.shopping_basket_outlined,
            size: 300,
          ),
          const SizedBox(height: 10),
          const Text(
            "Your List is Empty",
            style: TextStyle(
                fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),


          const Text(
            "Create list and add them to your trolley\n \tfor an easier shopping experience",style: TextStyle(fontSize: 17),),
          const SizedBox(height: 60),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ListsPageViewModel viewModel = Provider.of<ListsPageViewModel>(context,listen: false);
                viewModel.addList(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,padding: const EdgeInsets.all(18)),

              child: const Text("Add List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  _buildListItem(BuildContext context,int index) {
    ListsPageViewModel viewModel = Provider.of<ListsPageViewModel>(context,listen: false);
    double deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<ListModel>(builder: (context,list,child){
         return Dismissible(
           key: Key("key_${list.listId}"),

           background: const Row(mainAxisAlignment: MainAxisAlignment.end,mainAxisSize: MainAxisSize.min,children: [
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 16),
               child: Icon(CupertinoIcons.clear,size: 50,color: Colors.redAccent,),
             )
           ],),


           onDismissed: (direction) {
                viewModel.deleteList(index);

           },
           child: Container(
             margin: const EdgeInsets.only(bottom: 20),
             child: Row(

               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  children: [
                    Text(list.listDate.substring(0,2),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(list.listDate.substring(2,6)),

                  ],
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: viewModel.getColor(list),
                    borderRadius: BorderRadius.circular(15),
                   boxShadow: [
                     BoxShadow(color: viewModel.getColor(list),blurRadius: 15,offset: Offset.fromDirection(BorderSide.strokeAlignCenter))
                   ]

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                         Text("${list.itemsCount.toString()} items" ?? "0 items",style: Constants.getListCardTextStyle(16),),
                        SizedBox(height: deviceHeight*0.04,),

                        Text(list.listName,style: Constants.getListCardTextStyle(18),),
                        SizedBox(height: deviceHeight*0.01,),

                        Row(

                          children: [
                          const Icon(Icons.group,color: Colors.white,),
                            SizedBox(width: deviceHeight*0.02,),
                             Text("Rıdvan Bekleviç",style: Constants.getListCardTextStyle(16),),

                        ],)
                      ],
                    ),
                  ),
                )
              ],
                     ),
           ),
         );

    });
  }


}
