import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_exception.dart';
import '../private_values.dart';

class Authentication {
  static const String baseUrl = PrivateValues.authBaseUrl;

  static const String login = '/Guest/ClientLogin';

  static Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${PrivateValues.authBaseUrl}$login'));
    request.body = json.encode({'mail': email, 'password': password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      if (!result['finalResult']) {
        throw AuthException.fromMap(result);
      }
      return result['token'];
    } else {
      // print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}
