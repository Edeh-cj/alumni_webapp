import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:alumni_webapp/repositories/_.dart';

import '../models/alumni.dart';

extension AlumniRepo on Repository{

  Future createAlumni(Alumni alumni) async{
    const path = '';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'name' : alumni.name,
      'email' : alumni.email,
      'occupation' : alumni.occupation,
      'degree' : alumni.degree,
      'department' : alumni.department,
      'year_of_graduation': alumni.yearOfGraduation
    });

    final response = await http.post(
      baseuri(path),
      headers: headers,
      body: body
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Alumni>> getAllAlumni() async{
    const path = '';

    final headers = {
      'Content-Type' :'application/json'
    };

    final response = await http.get(
      baseuri(path),
      headers: headers
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Alumni> alumniList = data.map(
        (e) => Alumni(
          name: e['name'], 
          email: e['email'], 
          occupation: e['occupation'], 
          degree: e['degree'], 
          department: e['department'], 
          yearOfGraduation: e['year_of_graduation'], 
          id: e['id']
        )
      ).toList();
      return alumniList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future sendMail({required String title, required String message, required List<Alumni> members, required Uint8List? attachment }) async{
    await Future.delayed(const Duration(seconds: 4));

  }

}