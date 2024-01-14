import 'package:get/get.dart';
import 'package:shop_app/data/repository/auth_repo.dart';
import 'package:shop_app/models/sign_up_model.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<bool> registration(SignUpModel signUpModel) async {
    _isLoaded = true;
    update();
    return await authRepo.registration(signUpModel);
  }

  Future<bool> login(String username, String password) async {
    ;
    var res = authRepo.login(username, password);
    _isLoaded = true;
    update();
    print(res);
    return res;
  }

  bool logout() {
    return authRepo.logout();
  }
}