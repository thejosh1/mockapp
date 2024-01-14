import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  ApiClient({ required this.appBaseUrl,}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
    };
  }

  void updateHeader() {
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try{
      Response res = await get(uri,
          headers: headers??_mainHeaders
      );
      return res;
    } catch(e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}