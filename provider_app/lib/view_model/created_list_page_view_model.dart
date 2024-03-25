import 'package:flutter/material.dart';


class CreatedListPageViewModel with ChangeNotifier {
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late GlobalKey<FormState> _formKey;
  int _myPriority = 0;




  DateTime? _selectedDate = DateTime.now();


  final DateTime _onceDate = DateTime((DateTime.now().year)-4);

  final DateTime _nextDate = DateTime(DateTime.now().year+10);


  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  CreatedListPageViewModel() {
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    _formKey = GlobalKey<FormState>();

  }

  List<String> priorityList = ["High", "Medium", "Low"];
  String? selectedPriority;



  void setSelectedPriority(String priority) {
    selectedPriority = priority;
    notifyListeners();
  }

  void changeValue(int value) {
    _myPriority = value;
    notifyListeners();
  }



  Future<DateTime?> showMyDatePicker(BuildContext context) async {

    _selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _onceDate,
      lastDate: _nextDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), // Temanızı seçin
          child: child!,
        );
      },
    );

    return _selectedDate;
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showMyDatePicker(context); // Tarih seçicisini aç ve seçilen tarihi al
    if (pickedDate != null) {
      selectedDate = pickedDate; // Seçilen tarihi güncelle
    }
  }







  TextEditingController get nameController => _nameController;

  TextEditingController get dateController => _dateController;

  GlobalKey<FormState> get formKey => _formKey;

  int get myPriority => _myPriority;

  set myPriority(int value) {
    _myPriority = value;
  }




}
