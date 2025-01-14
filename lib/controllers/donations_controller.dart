import '_.dart';

extension DonationsController on Controller{
  getTotalDonations(){
    toggleLoading(true);
    Future.delayed(const Duration(seconds: 4)).then((value) => totalDonations = 300945);
    toggleLoading(false);
    
  }
}