import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/auth_exception.dart';
import '../../services/authentication.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Authentication.loginWithEmailPassword(
        email: 'oussama.messaoudi.info@gmail.com',
        password: 'aR23s7BV0NTQ17551MdEYTxvtjy',
      ),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login with Email and Password'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (snapshot.connectionState == ConnectionState.waiting)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SpinKitRing(
                    color: Theme.of(context).primaryColor,
                    lineWidth: 3,
                    size: 40,
                  ),
                ),
              if (snapshot.hasError) ...[
                const SizedBox(
                  width: double.infinity,
                  height: 200,
                ),
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 40,
                ),
                Builder(builder: (context) {
                  late String errorMessage;
                  Object? e = snapshot.error;
                  if (e is AuthException) {
                    errorMessage = 'Error Occured\n${e.error}';
                  } else {
                    errorMessage = 'Error Occured\n${e.toString()}';
                  }
                  return Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  );
                }),
              ],
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) ...[
                const SizedBox(
                  width: double.infinity,
                  height: 200,
                ),
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 40,
                ),
                Text(
                  'Perfect! here is your token:\n\n\n${snapshot.data}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
