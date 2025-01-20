import 'package:alumni_webapp/models/user.dart';

import '_.dart';

extension AuthController on Controller{

  Future loginAdmin(String email, String passkey) async{
    toggleLoading(true);
    try {
      User? user = await repository.authenticate(email, passkey);
      adminUser = user;
      toggleLoading(false);
    }
    catch(error){
      toggleLoading(false);
      rethrow;
    }

    
  }

  signout() {
    adminUser = null;
    toggleLoading(false);
  }
}