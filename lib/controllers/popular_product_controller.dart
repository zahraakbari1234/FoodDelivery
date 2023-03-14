import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import '../data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';

import '../models/cart_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo; //  برای اینکه به repository آن دسترسی داشته باشیم instance گرفتیم
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = []; //دیتاهایی که repo برمیگردونه رو توی این لیست ذخیره میکنیم
  List<dynamic> get popularProductList => _popularProductList;//چون _ داره private هست
  // وقتی get  استفاده میکنیم از اون متغییر خارج از این کلاس هم میشه استفاده کرد

   bool _isLoaded = false;
   bool get isLoaded => _isLoaded;

   int _quantity = 0 ;
   int get quantity => _quantity;

   int _inCartItems = 0 ;
   int get inCartItems => _inCartItems + _quantity;

   late CartController _cart;

  Future<void> getpopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){ //successful
     // print('got product');// for testing
      _popularProductList = []; // اگر این خط را ننویسیم دیتا چندبار تکرار میشه چون این تابع چند بار فراخوانی میشه
      _popularProductList.addAll(product.fromJson(response.body).products); // we need to convert json data to model
      //print(_popularProductList);// for testing
      _isLoaded = true ;
      update(); // SetState() مثل
    }else{


    }
  }

   void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1) ;
    }else{
      _quantity = checkQuantity(_quantity-1) ;
    }
    update(); // built inside GETX package
  }
   int checkQuantity(int quantity){
    if((_inCartItems+quantity) < 0){
      Get.snackbar('item count', 'you cant reduce more !',
      backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity = _inCartItems ;
        return quantity;
      }
      return 0;
    }else if( (_inCartItems+quantity) > 20){
      Get.snackbar('item count', 'you cant add more !',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20 ;
    }else{
      return quantity;
    }
  }
   void initProduct(ProductModel product , CartController cart){

      _quantity = 0 ;
      _inCartItems = 0 ;
      _cart = cart;
      var exist = _cart.existInCart(product);
      print('exist or not  $exist');
      //if exist
     if(exist){
       //get from storage _inCartItems
       _inCartItems = _cart.getQuantity(product);
     }
      //print('the quantity in cart is $_inCartItems');
   }

   void addItem (ProductModel product){

      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      update();

   }

   int get totalItems{
    return _cart.totalItems;
   }

   List<CartModel> get getItems{
    return _cart.getItems;
   }

}