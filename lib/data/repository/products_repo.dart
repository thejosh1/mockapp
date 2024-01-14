import 'package:get/get.dart';
import 'package:shop_app/data/api/api_client.dart';
import 'package:shop_app/utils/app_constants.dart';

class ProductsRepo extends GetxService {
  final ApiClient apiClient;

  ProductsRepo({required this.apiClient});

  Future<Response> getProductsList() async {
    return await apiClient.getData(AppConstants.PRODUCTS_URI);
  }
}