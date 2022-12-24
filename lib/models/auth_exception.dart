import 'dart:convert';

AuthException authExceptionFromMap(String str) =>
    AuthException.fromMap(json.decode(str));

String authExceptionToMap(AuthException data) => json.encode(data.toMap());

class AuthException implements Exception {
  AuthException({
    required this.finalResult,
    required this.error,
  });

  final bool finalResult;
  final String error;

  factory AuthException.fromMap(Map<String, dynamic> json) => AuthException(
        finalResult: json['finalResult'],
        error: json['error'],
      );

  Map<String, dynamic> toMap() => {
        'finalResult': finalResult,
        'error': error,
      };
}
