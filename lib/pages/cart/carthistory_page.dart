import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*
    دسترسی به cart controller
     */
    var  getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList(); //برای اینکه سفارش های جدید در بالای لیست قراربگیرند

    Map<String , int> cartItemsPerOrder = Map();

    for(int i = 0 ; i < getCartHistoryList.length ; i++ ) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
        }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrdetTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    return Scaffold(
      body:Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.getHeight(100),
            padding: EdgeInsets.only(top: Dimensions.getHeight(45)),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: 'Cart History', color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined , backGroundColor: AppColors.yellowColor, iconColor: Colors.white,)
              ],
            ),
          ),
          Expanded( //WE WANT IT TO TAKE ALL THE AVAILABLE SPACE
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.getHeight(20),
                      right: Dimensions.getHeight(20),
                      left: Dimensions.getHeight(20),
              ),

             // list view compile ND RENDER ON RUNTIME BUT listviewbuilder DO IT ON DEMAND

             child: MediaQuery.removePadding(
               removeTop: true,
               context: context,
               child: ListView( // حتما نیاز به ارتفاع در parent دارد
               children:[
                 for( int i =0 ; i< itemsPerOrder.length ; i++)
                   Container(
                     margin: EdgeInsets.only(bottom:Dimensions.getHeight(20) ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         // TO SHOW DATE IN SPECIAL FORMAT
                         ((){
                           DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].time!);
                           var inputDate = DateTime.parse(parseDate.toString());
                           var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
                           var outputDate = outputFormat.format(inputDate);
                           return BigText(text: outputDate);
                         }()),

                         SizedBox(height:Dimensions.getHeight(10)),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Wrap(
                                 direction: Axis.horizontal,

                                 //ORDERED ITEMS
                                 children: List.generate(itemsPerOrder[i], (index) {
                                   if(listCounter < getCartHistoryList.length){
                                     listCounter++;
                                   }
                                   return index<=2 ? Container(
                                     width: Dimensions.getHeight(80),
                                     height:Dimensions.getHeight(80) ,
                                     margin: EdgeInsets.only(right:Dimensions.getHeight(5) ),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(Dimensions.getHeight(5)),
                                       image: DecorationImage(
                                         fit: BoxFit.cover,
                                         image: NetworkImage(
                                             APPConstants.BASE_URL + APPConstants.UPLOAD_URL + getCartHistoryList[listCounter-1].img!//برای اینکه اولین بار 0 باشه منهای یک میکنیم
                                         ),
                                       ),
                                     ),
                                   ) : Container();
                                 },),
                               ),

                               //ONE MORE SECTION
                               Container(
                                 height: Dimensions.getHeight(80),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                     SmallText(text: 'Total', color: AppColors.titleColor,),
                                     BigText(text: '${itemsPerOrder[i]}Items' , color: AppColors.titleColor,),
                                     GestureDetector(
                                       onTap: (){

                                         var orderTime = cartOrdetTimeToList();
                                         Map<int , CartModel> moreOrder = {};
                                         for(int j =0 ; j <getCartHistoryList.length ; j++){
                                           if(getCartHistoryList[j].time == orderTime[i]){
                                             moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                             CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                             );
                                           }
                                         }
                                         Get.find<CartController>().setItems = moreOrder;
                                         Get.find<CartController>().addToCartList();

                                       },
                                       child: Container(
                                         padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(8) , vertical:Dimensions.getHeight(5)),
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(Dimensions.getHeight(5)),
                                           border: Border.all(width: Dimensions.getHeight(1) , color: AppColors.mainColor)
                                         ),
                                         child:  SmallText(text:'one more' , color: AppColors.mainColor,),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ]),
                       ],
                     ),
                   ),
               ],
             ),)
            ),
          ),
        ],
      ),
    );
  }
}
