import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.getHeight(60),
              left: Dimensions.getHeight(20),
              right: Dimensions.getHeight(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    backGroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.getHeight(24),
                  ),
                  SizedBox(width:Dimensions.getHeight(100)),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      backGroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.getHeight(24),
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    backGroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.getHeight(24),
                  ),
                ],
              )

          ),

          //LIST OF ITEMS
          Positioned(
              top: Dimensions.getHeight(100),
              left: Dimensions.getHeight(20),
              right: Dimensions.getHeight(20),
              bottom: 0,
              child: Container(
                //color: Colors.blueGrey,

                //حذف فاصله بالای لیست
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder:(_,index){
                          return Container(
                            margin: EdgeInsets.only(top: Dimensions.getHeight(10)),
                            height: 100,
                            width: double.maxFinite,
                            child: Row(
                              children: [

                                //IMAGE SECTION
                                GestureDetector(
                                  onTap:(){
                                    var popularIndex = Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[index].product!);

                                    if(popularIndex >= 0){
                                      Get.toNamed(RoutesHelper.getPopularFood(popularIndex , 'cart-page'));
                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[index].product!);
                                      Get.toNamed(RoutesHelper.getRecommendedFood(recommendedIndex , 'cart-page'));
                                    }
                                     },
                                  child: Container(
                                    height: Dimensions.getHeight(100),
                                    width: Dimensions.getHeight(100),
                                    margin: EdgeInsets.only(bottom: Dimensions.getHeight(10)  ),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                               APPConstants.BASE_URL  + APPConstants.UPLOAD_URL + _cartList[index].img!,
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(width:Dimensions.getHeight(10),),

                                //we want to take all the available space of parent(Row)
                                Expanded(child: Container(
                                  height: Dimensions.getHeight(100),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: _cartList[index].name!,
                                        color: Colors.black54,
                                      ),
                                      SmallText(text:'spicy'),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          //price section
                                          BigText(text: '\$${ cartController.getItems[index].price!}',
                                            color: Colors.redAccent,
                                          ),

                                          //add remove section
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: Dimensions.getHeight(10),
                                                right: Dimensions.getHeight(10),
                                                top: Dimensions.getHeight(10),
                                                bottom: Dimensions.getHeight(10)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(_cartList[index].product! , -1);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.getHeight(5),
                                                ),
                                                BigText(text: _cartList[index].quantity.toString()), //popularProduct.inCartItems.toString()),
                                                SizedBox(
                                                  width: Dimensions.getHeight(5),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(_cartList[index].product! , 1);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      )

                                    ],
                                  ),

                                ))
                              ],
                            ),
                          );
                        }
                    );
                  }),
                ),
              ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){ //گرفتن instance از controller
        return Container(
          height: Dimensions.getHeight(120),
          padding: EdgeInsets.only(
            top: Dimensions.getHeight(30),
            bottom: Dimensions.getHeight(30),
            left: Dimensions.getHeight(20),
            right: Dimensions.getHeight(20),
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.getHeight(20) * 2),
              topRight: Radius.circular(Dimensions.getHeight(20) * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // white add remove box
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.getHeight(20),
                    right: Dimensions.getHeight(20),
                    top: Dimensions.getHeight(20),
                    bottom: Dimensions.getHeight(20)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [

                    SizedBox(
                      width: Dimensions.getHeight(5),
                    ),
                    BigText(text: '\$${cartController.totalAmount}'),
                    SizedBox(
                      width: Dimensions.getHeight(5),
                    ),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  cartController.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.getHeight(20),
                      right: Dimensions.getHeight(20),
                      top: Dimensions.getHeight(20),
                      bottom: Dimensions.getHeight(20)),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                  ),
                  child: BigText(
                    text: 'Check Out',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),

    );
  }
}
