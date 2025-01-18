import 'dart:typed_data';

import 'package:alumni_webapp/repositories/_.dart';

import '../models/alumni.dart';

extension AlumniRepo on Repository{

  Future createAlumni(Alumni alumni) async{
    return await Future.delayed(const Duration(seconds: 2)).then((value) => Alumni.dummy(id: 1),);
  }

  Future<List<Alumni>> getAllAlumni() async{
    return await Future.delayed(const Duration(seconds: 2)).then((value) => List.generate(4, (index) => Alumni.dummy(id: index))  );
  }

  Future sendMail({required String title, required String message, required List<Alumni> members, required Uint8List? attachment }) async{
    await Future.delayed(const Duration(seconds: 4));
  }

}