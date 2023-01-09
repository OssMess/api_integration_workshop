import 'dart:convert';

import 'package:api_integration_workshop/private_values.dart';
import 'package:http/http.dart' as http;

class ChargilyGateway {
  static const String baseUrl = 'https://epay.chargily.com.dz';

  static const String invoice = '/api/invoice';

  ///Generate an invoice on Chargily Payement Gateway using:
  ///
  ///[client] as your client name,
  ///
  ///[clientEmail] as your client email,
  ///
  ///[invoiceNumber] Order number will be used to check payment response,
  ///
  ///[amount] Order total amount must be greater than or equal `75`,
  ///
  ///`discount` Discount percentage between 0 and 99.99,
  ///
  ///`back_url` This url you will be redirected to after the payment is done, and must be active URL,
  ///
  ///`webhook_url` This is the source url wich you will get information of payment responce
  ///
  ///[mode] This is the payment method `EDAHABIA` or `CIB`
  ///
  ///[comment] Description for the payment raison
  static Future<String> generateInvoice({
    required String client,
    required String clientEmail,
    required double amount,
    required String invoiceNumber,
    required PaymentMode mode,
    required String? comment,
  }) async {
    var headers = {
      'X-Authorization': PrivateValues.chargilyApiKey,
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://epay.chargily.com.dz/api/invoice'));
    request.body = json.encode({
      "client": client,
      "client_email": clientEmail,
      "amount": amount,
      "invoice_number": invoiceNumber,
      "back_url": "https://developers.google.com", //you
      "webhook_url":
          "https://mybackend.cloudfunctions.net/chargilyPaymentConfirmationRequest",
      "mode": paymentModeToString(mode),
      "discount": 0,
      "comment": comment,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      if (result['checkout_url'] == null) {
        throw Exception('Checkout Url not found!');
      }
      return result['checkout_url'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

enum PaymentMode {
  // ignore: constant_identifier_names
  EDAHABIA,
  // ignore: constant_identifier_names
  CIB,
}

String paymentModeToString(PaymentMode value) {
  switch (value) {
    case PaymentMode.EDAHABIA:
      return 'EDAHABIA';
    case PaymentMode.CIB:
      return 'CIB';
    default:
      throw Exception('Value not in range');
  }
}

PaymentMode stringToPaymentMode(String value) {
  switch (value) {
    case 'EDAHABIA':
      return PaymentMode.EDAHABIA;
    case 'CIB':
      return PaymentMode.CIB;
    default:
      throw Exception('Value not in range');
  }
}
