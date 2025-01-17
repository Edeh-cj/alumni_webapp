import 'package:alumni_webapp/models/user.dart';

import '_.dart';

extension AuthController on Controller{

  loginAdmin(String email, String passkey) async{
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 3)).then((value) => adminUser = User(email: 'Jacobi@gmail.com', id: 2));
    toggleLoading(false);
  }
}