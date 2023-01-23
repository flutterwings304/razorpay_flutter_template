import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final razorPayKey = dotenv.get("RAZOR_KEY");
  final razorPaySecret = dotenv.get("RAZOR_SECRET");
  razorPayApi(num amount) async {
    var headers = {
      'content-type': 'application/json',
      'Authorization': 'Basic $razorPayKey'
    };
    var request =
        http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
    request.body = json.encode({
      "amount": amount * 00, // Amount in smallest unit like in paise for INR
      "currency": "INR", //Currency
      "receipt": "rcptid_11" //Reciept Id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return {
        "status": "success",
        "body": (await response.stream.bytesToString())
      };
    } else {
      return {"status": "fail", "message": (response.reasonPhrase)};
    }
  }
}
