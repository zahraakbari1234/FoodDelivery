import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{

  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){

    var time = DateTime.now().toString();
    cart=[];//اول خالیش میکنیم بعد توش مینویسیم که چندبار ننویسه

    // error:Converting object to an encodable object failed: Instance of 'CartModel'
    //  چون CartModel یک رشته نیست و object است باید به  json و رشته تبدیل میکنیم البته اول یه تغییراتی توی cartModel هم میدیم
    /*
    convert object to string because sharedPreferences get string
     */
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    //save it as a list in storage
    sharedPreferences.setStringList(APPConstants.CART_LIST, cart);

    getCartList();
    //print(sharedPreferences.getStringList(APPConstants.CART_LIST));
  }

  //برعکس تابع بالا تبدیل از string  به list of cartModel
  List<CartModel> getCartList(){

    List<CartModel> cartList = [];
    List<String> carts =[];

    if(sharedPreferences.containsKey(APPConstants.CART_LIST)){
      carts= sharedPreferences.getStringList(APPConstants.CART_LIST)!;
      //print('inside getcartlist is  $carts');
    }

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    /*با بالایی یکی است

        carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

     */

    return cartList;
  }

  List<CartModel> getCartHistoryList(){

    List<CartModel> cartHistoryList = [];

    if(sharedPreferences.containsKey(APPConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory= sharedPreferences.getStringList(APPConstants.CART_HISTORY_LIST)!;
    }

    for (var element in cartHistory) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    }

    /*با بالایی یکی است

        carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

     */

    return cartHistoryList;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(APPConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(APPConstants.CART_HISTORY_LIST)!;
    }
    for(int i = 0 ; i < cart.length ; i++){
      print('cart history is ${cart[i]}');
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(APPConstants.CART_HISTORY_LIST, cartHistory);
    getCartHistoryList();
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(APPConstants.CART_LIST);
  }


}