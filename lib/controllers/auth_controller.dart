import 'package:alumni_webapp/models/user.dart';

import '_.dart';

extension AuthController on Controller{

  Future loginAdmin(String email, String passkey) async{
    toggleLoading(true);
    User? user = await repository.authenticate(email, passkey);
    adminUser = user;
    toggleLoading(false);
  }
}