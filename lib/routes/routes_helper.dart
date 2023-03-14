import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/spalsh_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';

class RoutesHelper{
  static const String splashpage = 'splash-page';
  static const String initial = '/';
  static const String popularfood = '/popular-food';
  static const String recommendedfood = '/recommended-food';
  static const String cartpage = '/cart-page';

  static getSpalshPage() => '$splashpage';
  static getInitial() => '$initial'; // برای اینکه بتونیم متغغیر پاس بدیم اومدیم از get استفاده کردیم
  static getPopularFood(int pageId , String page) => '$popularfood?pageId=$pageId&page=$page';//?pageId  means passing parameters to popularfood

  static getRecommendedFood(int pageId, String page) => '$recommendedfood?pageId=$pageId&page=$page';

  static getCartPage() => '$cartpage';

  static List<GetPage> routes= [

    GetPage(name: '/splash-page', page: () =>  const SplashScreen()),

    GetPage(name: '/', page: () =>  const HomePage()),

    GetPage(name: '/popular-food', page: () {
      var pageId = int.parse(Get.parameters['pageId']!);//اینجا خروجی string میده واسه همینم خط بعد parse میکنیم
      var page = Get.parameters['page']!;

      return PopularFoodDetail(pageId: pageId , page: page);

    },
    transition: Transition.fadeIn,
    ),

    GetPage(name: '/recommended-food', page: () {

      var pageId = int.parse(Get.parameters['pageId']!);//اینجا خروجی string میده واسه همینم خط بعد parse میکنیم
      var page = Get.parameters['page']!;
      return RecommendedFoodDetail(pageId: pageId , page: page);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: '/cart-page', page: (){
      return CartPage();
    },
      transition: Transition.fadeIn,
    ),

  ];
}