import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init()async {

 //load data from storage and merge it from satemanagementsystem(getx)
 final sharedPreferences = await SharedPreferences.getInstance();
 Get.lazyPut(( ) => sharedPreferences);


 //api client
 Get.lazyPut(( ) => ApiClient(appBaseUrl: APPConstants.BASE_URL));

 //repos
 Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => CartRepo( sharedPreferences: Get.find()));

 //controllers
 Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
 Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
 Get.lazyPut(() => CartController(cartRepo: Get.find()));

}