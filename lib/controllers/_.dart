import 'package:alumni_webapp/models/alumni.dart';
import 'package:alumni_webapp/models/donation_record.dart';
import 'package:alumni_webapp/models/user.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier{
  bool isLoading = false;
  int totalDonations = 30000;
  User? adminUser;
  List<Alumni> members = List.generate(9, (index) => Alumni.dummy(id: index));

  List<DonationRecord> donationRecords = [DonationRecord.dummy(), DonationRecord.dummy(), DonationRecord.dummy()];

  toggleLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}