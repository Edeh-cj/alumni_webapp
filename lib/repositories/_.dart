import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:alumni_webapp/models/user.dart';

class Repository {
  Uri baseuri (String path)=> Uri.parse('http://127.0.0.1:8000/api/alumni_api$path');

  Future<User> authenticate(String email, String passkey) async{

    const path = '/authenticate';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'pass_key' : passkey,
      'email' : email.toLowerCase()
    });

    final response = await http.post(
      baseuri(path),
      headers: headers,
      body: body
    );
    
    if (response.statusCode == 200) {
      return User(email: email, id: 1);
    } else {
      throw Exception( response.reasonPhrase);
    }
    
  }
  
}