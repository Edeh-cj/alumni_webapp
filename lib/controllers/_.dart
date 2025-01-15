import 'package:alumni_webapp/models/alumni.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier{
  bool isLoading = false;
  int totalDonations = 30000;
  List<Alumni> members = List.generate(9, (index) => Alumni.dummy(id: index));

  toggleLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}