import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:alumni_webapp/models/donation_record.dart';
import 'package:alumni_webapp/repositories/_.dart';

extension DonationsRepo on Repository{

  Future<int> getDonationTotal()async{
    const path = '/donations/total_amount';

    final headers = {
      'Content-Type' : 'application/json'
    };

    final response = await http.get(
      baseuri(path),
      headers: headers  
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      return data;

    } else {
      throw Exception(response.reasonPhrase);
    }

  }

  Future<List<DonationRecord>> getDonationHistory() async{
    const path = '/donations';

    final headers = {
      'Content-Type' : 'application/json'
    };

    final response = await http.get(
      baseuri(path),
      headers: headers  
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map(
        (e) => DonationRecord(
          name: e['name'], 
          email: e['email'], 
          amount: e['amount'], 
          time: DateTime.parse(e['created_at'])
        )
      ).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
    
  }

  Future<String> initializePayment(String name, String email, int amount, )async{

    const path = '/donations/initialize';
    final body = jsonEncode({
      'email' : email,
      'amount' : amount,
      'name' : name
    }); 

    final response = await http.post(
      baseuri(path),
      body: body,
      headers: {
        'Content-Type' : 'application/json',
                
      }
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"]['authorization_url'];
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future sendPaymentToken(int token) async{}
}