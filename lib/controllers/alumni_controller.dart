import 'dart:io';

import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/models/alumni.dart';

extension AlumniController on Controller {

  createAlumni(Alumni alumni)async{
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 3));
    toggleLoading(false);
  }
  
  sendMail({required List<Alumni> alumni, required String title, required String message, required File? attachment} ){}
}