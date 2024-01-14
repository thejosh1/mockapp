import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class UserRepo {
  final User user;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.sharedPreferences, required this.user});

  Future<User> getUserInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    user.name = pref.getString('username')??null;
    user.email = pref.getString('email')??null;
    user.address = pref.getString('address')??null;
    return user;
  }
}