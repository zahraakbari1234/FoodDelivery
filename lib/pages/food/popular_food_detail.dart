import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/column.dart';
import '../../widgets/expandable_text_widget.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:get/get.dart';


class PopularFoodDetail extends StatelessWidget {
   final int pageId;
   final String page;
   const PopularFoodDetail(  {Key? key,required this. pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product , Get.find<CartController>()); // اول شروع صفحه این تابع فراخوانی میشه

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //back image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.getHeight(350),
              decoration:  BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(APPConstants.BASE_URL + APPConstants.UPLOAD_URL + product.img!),),
              ),
            ),
          ),

          // back and cart icons
          Positioned(
            top: Dimensions.getHeight(45),
            left: Dimensions.getHeight(20),
            right: Dimensions.getHeight(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page == 'cart-page'){
                      Get.toNamed(RoutesHelper.getCartPage());
                    }else{
                      Get.toNamed(RoutesHelper.getInitial());
                    }
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap:(){
                      Get.toNamed(RoutesHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),

                        // items in cart shows over shopping circle dynamic
                        Get.find<PopularProductController>().totalItems >= 1 ?
                            Positioned(
                              right:0, top:0,
                              child: AppIcon(icon: Icons.circle , size: 20,
                                iconColor: Colors.transparent,
                                backGroundColor: AppColors.mainColor,),
                            )
                            : Container(),


                         // number
                        Get.find<PopularProductController>().totalItems >= 1 ?
                        Positioned(
                          right:3, top:3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12,
                            color: Colors.white,
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),

          //bottom section
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.getHeight(350) - 40,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.getWidth(20),
                  right: Dimensions.getWidth(20),
                  top: Dimensions.getHeight(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.getHeight(20)),
                  topLeft: Radius.circular(Dimensions.getHeight(20)),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.getHeight(10),
                    left: Dimensions.getWidth(15),
                    right: Dimensions.getWidth(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     AppColumn(
                      text: product.name,
                      stars: 5,
                    ),
                    SizedBox(
                      height: Dimensions.getHeight(20),
                    ),
                    BigText(text: 'Introduce'),
                    SizedBox(height: Dimensions.getHeight(20)),

                    //Expandable text section
                     Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableTextWidget(
                              text:
                              product.description!,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){ //گرفتن instance از controller
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
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.getHeight(5),
                    ),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(
                      width: Dimensions.getHeight(5),
                    ),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
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
                    text: '\$${product.price!} Add to Cart',
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
