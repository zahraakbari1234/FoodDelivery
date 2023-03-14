import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;

  late Map<String , String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds:30);
    token = APPConstants.TOKEN;// اگر نزاری چون late هست در runtime ارور میده
    _mainHeaders = {
      'content-type' : 'application/json; charset=UTF-8',//نوع دیتا و انکودینگ دیتا دریافتی چی باشه
      'Authorization' : 'Bearer $token', // وقتی get های مختلف داریم از توکن برای امنیت ارتباط استفاده شده
    };
  }

  //create get method (getting data from an endpoint

  Future<Response> getData(String uri) async{
    try{ // سعی کن دیتا رو از endpoint بگیری و بریزی توی response
      Response response = await get(uri);
      return response;
    }catch(e){ // در صوزت وجود ارور نمایش بده با کد 1
      return  Response(statusCode: 1 , statusText: e.toString());

    }
  }
}