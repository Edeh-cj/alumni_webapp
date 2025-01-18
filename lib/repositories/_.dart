import 'package:alumni_webapp/models/user.dart';

class Repository {
  Uri baseuri (String path)=> Uri.parse('http://127.0.0.1:8000/api$path');

  Future<User> authenticate(String email, String passkey) async{
    return await Future.delayed(const Duration(seconds: 2)).then((value) => User(email: 'email', id: 2));
  }
  
}