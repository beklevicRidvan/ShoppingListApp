import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/view_model/created_list_page_view_model.dart';
import 'package:intl/intl.dart';

class CreatedListPage extends StatelessWidget {
  const CreatedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

 AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Created Page List"),
      actions:const [
         Icon(Icons.create),
      ],
    );
 }



 _buildBody(BuildContext context){
   CreatedListPageViewModel viewModel = Provider.of(context,listen: false);

   return Form(
     key: viewModel.formKey,
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(

         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           _buildTextFieldLabel("Add List Name"),
           _buildListNameTextField(context),
           _buildTextFieldLabel("Due Date"),
           _buildDatePicker(context),
           _buildTextFieldLabel("Add Collaborators"),
           _buildAddCollaborators(context),
           _buildTextFieldLabel("Set Priority"),
           _buildPriorityButton(context),
           _buildCreateListButton(context),
           _buildClearListButton(context),
         ],
       ),
     ),
   );
 }


  Widget _buildListNameTextField(BuildContext context) {
    CreatedListPageViewModel viewModel = Provider.of(context,listen: false);

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name area can't be empty";
        } else {
          return null; // Geçerli durum
        }
      },
      controller: viewModel.nameController,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent))),
    );
  }

  Widget _buildDateField(BuildContext context) {

    CreatedListPageViewModel viewModel = Provider.of(context,listen: false);

    return TextFormField(
      controller: viewModel.dateController,
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.date_range),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent))),
    );
  }


  Widget _buildDatePicker(BuildContext context){
    return Consumer<CreatedListPageViewModel>(builder: (context, viewModel, child) {
      return GestureDetector(
        onTap: (){
          viewModel.selectDate(context);
        },
        child: Container(
          decoration: const BoxDecoration(
            border: BorderDirectional(bottom: BorderSide(color: Colors.black)),
          ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(viewModel.selectedDate != null ? DateFormat('dd MMM yyyy').format(viewModel.selectedDate!) : 'Select a Date',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.date_range),
              ),
            ],
          ),
        ),
      );
    },);
  }

  Widget _buildAddCollaborators(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: (value) {},
      items: const [
        DropdownMenuItem(child: Text("Rıdvan Bekleviç")),
      ],
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.group),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent))),
    );
  }

  Widget _buildTextFieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPriorityButton(BuildContext context) {
    return Consumer<CreatedListPageViewModel>(
      builder: (context, viewModel, child) {
        return DropdownButtonFormField(
          value: viewModel.priorityList[viewModel.myPriority],
          items: viewModel.priorityList.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              int index = viewModel.priorityList.indexOf(value);
              viewModel.changeValue(index);
            }
          },
        );
      },
    );
  }


  Widget _buildCreateListButton(BuildContext context) {
    CreatedListPageViewModel viewModel = Provider.of<CreatedListPageViewModel>(context,listen: false);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
         if(viewModel.formKey.currentState!.validate()){
           List<dynamic> elMidi = [viewModel.nameController.text,DateFormat('dd MMM yyyy').format(viewModel.selectedDate!) ,"Rıdvan Bekleviç",viewModel.priorityList[viewModel.myPriority]];
           Navigator.pop(context,elMidi);
         }
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: Colors.redAccent),
        child: const Text(
          "Create List",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildClearListButton(BuildContext context) {
    CreatedListPageViewModel viewModel = Provider.of<CreatedListPageViewModel>(context,listen: false);

    return SizedBox(
      width: double.infinity,
      child: TextButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
          onPressed: () {
            viewModel.nameController.text ="";
          },
          child: const Text(
            "Clear List",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          )),
    );
  }
}
