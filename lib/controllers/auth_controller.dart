import '_.dart';

extension AuthController on Controller{

  loginAdmin(String email, String passkey) async{
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 3));
    toggleLoading(false);
  }
}