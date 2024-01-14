
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode==401) {
      Get.offNamed(RouteHelper.LOGIN);
    } else {
      ShowCustomSnackBar(response.statusText!);
    }
  }
}