class DonationRecord {
  final String name, email;
  final int amount;
  final DateTime time;

  DonationRecord({required this.name, required this.email, required this.amount, required this.time});
  DonationRecord.dummy():
    amount = 3000,
    name = 'Nwabuike Johnson',
    email = 'Johnson@gmail.com',
    time = DateTime.now();
}