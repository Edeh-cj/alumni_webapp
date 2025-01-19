import 'package:alumni_webapp/models/alumni.dart';
import 'package:alumni_webapp/models/donation_record.dart';
import 'package:alumni_webapp/models/user.dart';
import 'package:alumni_webapp/repositories/_.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier{
  final repository = Repository();

  bool isLoading = false;
  User? adminUser;
  List<Alumni> members = [];

  List<DonationRecord> donationRecords = [DonationRecord.dummy(), DonationRecord.dummy(), DonationRecord.dummy()];

  toggleLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}