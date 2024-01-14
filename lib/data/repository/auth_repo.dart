import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/api/api_client.dart';
import 'package:shop_app/models/sign_up_model.dart';
import 'package:shop_app/routes/route_helper.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.sharedPreferences
  });

  bool _canLogin = false;
  bool get canLogin => _canLogin;

  Future<bool> registration(SignUpModel signUpModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String username = signUpModel.name!;
    String email = signUpModel.email!;
    String address = signUpModel.address!;
    String password = signUpModel.password!;

    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('address', address);
    prefs.setString('password', password);

    print(prefs.getString('username'));
    print(prefs.getString('email'));
    print(prefs.getString('password'));

    return _canLogin;
  }

  Future<bool> login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    String enteredUsername = username;
    String enteredPassword = password;

    print(enteredUsername);
    print(enteredPassword);

    if (enteredUsername == savedUsername && enteredPassword == savedPassword) {
      _canLogin = true;

      print('${savedUsername}');
      print('${savedPassword}');
    }
    return true;
  }

  bool logout() {
    _canLogin = false;
    return true;
  }
}