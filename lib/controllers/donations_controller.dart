import 'package:alumni_webapp/repositories/donations_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/donation_record.dart';
import '_.dart';

extension DonationsController on Controller{

  Future<int> getTotalDonations() async{
    return repository.getDonationTotal();
    
  }

  Future<List<DonationRecord>> getDonationHistory() async{
    return repository.getDonationHistory();
  }

  onDonateClick(String name, String email, int amount) async{
    toggleLoading(true);
    await repository.initializePayment(name, email, amount)
      .then(
        (value) async{
          toggleLoading(false);
          await launchUrl(Uri.parse(value)).catchError((error){
            toggleLoading(false);
            throw Exception("couldn't launch redirect");
          });
        }
      ). catchError((error) {
        toggleLoading(false);
        throw Exception(error);
      });
  }

  Future makeDonations({
    required int cardNumber,
    required int cvv,
    required int expiryDate,
    required int amount,
    required int cardPin
   })async {
    toggleLoading(true);
    // await repository.initializePayment();
    toggleLoading(false);
  }

  Future sendPaymentToken(int token) async{
    toggleLoading(true);
    await repository.sendPaymentToken(token);
    toggleLoading(false);
  }
}