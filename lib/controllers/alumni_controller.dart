import 'dart:typed_data';

import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/models/alumni.dart';
import 'package:alumni_webapp/repositories/alumni_repo.dart';

extension AlumniController on Controller {

  Future createAlumni(Alumni alumni)async{
    toggleLoading(true);
    await repository.createAlumni(alumni);
    toggleLoading(false);
  }

  Future getAllAlumni() async {
    toggleLoading(true);
    await repository.getAllAlumni();
    toggleLoading(false);
  }
  
  Future sendMail ({required List<Alumni> alumni, required String title, required String message, required Uint8List? attachment} ) async{
    toggleLoading(true);
    await repository.sendMail(title: title, message: message, members: members, attachment: attachment);
    toggleLoading(false);
  }
}