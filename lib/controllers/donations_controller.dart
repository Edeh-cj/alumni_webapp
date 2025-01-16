import '_.dart';

extension DonationsController on Controller{

  Future getTotalDonations() async{
    toggleLoading(true);
    Future.delayed(const Duration(seconds: 4)).then((value) => totalDonations = 300945);
    toggleLoading(false);
    
  }

  Future makeDonations()async {
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 4));
    toggleLoading(false);
  }

  Future sendPaymentToken() async{
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 4));
    toggleLoading(false);
  }
}