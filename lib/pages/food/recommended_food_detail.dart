import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedFoodDetail({Key? key , required this. pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product , Get.find<CartController>()); // اول شروع صفحه این تابع فراخوانی میشه


    //print('page id is  ' + pageId.toString());
    //print('product name is' + product.name.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,

            //icons
            toolbarHeight: Dimensions.getHeight(80),
            title: Row(
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
                  child: AppIcon(icon: Icons.clear),
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

            //header text
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                child: Center(
                    child: BigText(
                  text: product.name,
                  size: Dimensions.getHeight(26),
                )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.getHeight(300), // عکس تا کجا بیاد پایین
            flexibleSpace: FlexibleSpaceBar(
              // برای اینکه عکس بتونه جمع و باز بشه
              background: Image.network(
                APPConstants.BASE_URL + APPConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // long body text
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimensions.getHeight(20),
                  right: Dimensions.getHeight(20)),
              child:  ExpandableTextWidget(
                text:
                  product.description!,
              ),
            ),
          ),
        ],
      ),

      //buttons

      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){

        return Column(
          mainAxisSize: MainAxisSize
              .min, // چون دو سری دکمه داخل container  نپیچیدیم پس size میزاریم
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.getHeight(20) * 2.5,
                right: Dimensions.getHeight(20) * 2.5,
                top: Dimensions.getHeight(10),
                bottom: Dimensions.getHeight(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        icon: Icons.remove,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.getHeight(24)),
                  ),
                  BigText(
                    text: '\$${product.price!} X ${controller.inCartItems}',
                    color: AppColors.mainBlackColor,
                    size: Dimensions.getHeight(26),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        icon: Icons.add,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.getHeight(24)),
                  )
                ],
              ),
            ),
            Container(
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
                        borderRadius:
                        BorderRadius.circular(Dimensions.getHeight(20)),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )),

                        GestureDetector(
                                onTap: (){
                                  controller.addItem(product);
                                },
                                child: Container(
                                     padding: EdgeInsets.only(
                                     left: Dimensions.getHeight(20),
                                     right: Dimensions.getHeight(20),
                                     top: Dimensions.getHeight(20),
                                     bottom: Dimensions.getHeight(20)),
                                    decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius:
                                        BorderRadius.circular(Dimensions.getHeight(20)),
                                ),
                                child: BigText(
                                    text: '\$${product.price!} Add to Cart',
                                    color: Colors.white,
                                ),
                                ),
                         ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
