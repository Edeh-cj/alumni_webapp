import 'package:alumni_webapp/repositories/_.dart';

extension DonationsRepo on Repository{

  Future<int> getDonationTotal()async{
    return Future.delayed(const Duration(seconds: 2)).then((value) => 32018);
  }

  Future initializePayment({
    required int  cardNumber, 
    required int cvv, 
    required int expiryDate, 
    required int amount, 
    required int cardPassword
  })async{}

  Future sendPaymentToken(int token) async{}
}