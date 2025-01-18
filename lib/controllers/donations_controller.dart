import 'package:alumni_webapp/repositories/donations_repo.dart';

import '_.dart';

extension DonationsController on Controller{

  Future<int> getTotalDonations() async{
    return repository.getDonationTotal();
    
  }

  Future makeDonations({
    required int cardNumber,
    required int cvv,
    required int expiryDate,
    required int amount,
    required int cardPin
   })async {
    toggleLoading(true);
    await repository.initializePayment(
      cardNumber: cardNumber, 
      cvv: cvv, 
      expiryDate: expiryDate, 
      amount: amount, 
      cardPassword: cardPin
    );
    toggleLoading(false);
  }

  Future sendPaymentToken(int token) async{
    toggleLoading(true);
    await repository.sendPaymentToken(token);
    toggleLoading(false);
  }
}