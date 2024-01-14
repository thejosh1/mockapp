import 'package:get/get.dart';
import 'package:shop_app/data/repository/user_repo.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  Future<User> getUserInfo() async{

    return await userRepo.getUserInfo();

  }
}