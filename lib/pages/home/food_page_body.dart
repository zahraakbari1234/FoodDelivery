import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../models/products_model.dart';
import '../../widgets/column.dart';
import 'package:food_delivery/routes/routes_helper.dart';

/*
مقدار page یک عدد اعشاری است که از صفر شروع میشود
 ********************************************/

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.getHeight(220);

  @override
  void initState(){
    super.initState();
    pageController.addListener(() { //تابع گرفتن مقدار page
      setState((){ // به محض تغییر مقدار page صفحه آپدیت میشه
        _currPageValue = pageController.page!;// null checker یعنی چک بشه نباید نال باشه
        //print(_currPageValue);
        //print(Dimensions.screenHeight);
      });
    });
  }

  /*
  برای این از dispose استفاده میشه که چیزایی که با خروج از صفحه نیازی بهشون نیس memmory رو آزاد کنن و
 حافظه زیاد نخواد برنامه
   */
  @override
  void dispose (){
    super.dispose();
    pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    /*
    showing items scrolling vertically
     */
    return Column(
      children: [

        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts){ // گرفتن دیتا سرور از کنترلر و آپدیت
          return popularProducts.isLoaded ? Container(
            height: Dimensions.getHeight(320),
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context,position){
                return _buildPageItem(position , popularProducts.popularProductList[position]);
              },
            ),
          ) :  CircularProgressIndicator(color: AppColors.mainColor,);
        }),


        //showing dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
      return    DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty ? 1:popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      );
    }),
        SizedBox(height: Dimensions.getHeight(30),),

        //recommended text
        Container(
          margin: EdgeInsets.only(left: Dimensions.getHeight(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(height: Dimensions.getHeight(30),),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(text: '.', color: Colors.black26,
                )
              ),
              SizedBox(height: Dimensions.getHeight(30),),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child:SmallText(text: 'Food Pairing'),
              )
            ],
          ),
        ),
        SizedBox(height: Dimensions.getHeight(20),),

        //list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
          return recommendedProducts.isLoaded ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),//لیست پایین کل صفحه رو بتونه scroll کنه و  گیر ننه جایی
              itemCount: recommendedProducts.recommendedProductList.length ,//تعداد آیتم های داخل لیست  همون index
              itemBuilder: (context , index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getRecommendedFood(index , 'home'));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.getHeight(20) , right: Dimensions.getHeight(20),
                        bottom: Dimensions.getHeight(10)
                    ),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          height: Dimensions.getHeight(120),
                          width: Dimensions.getWidth(120),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                            color: Colors.white38,
                            image:   DecorationImage(
                              fit: BoxFit.cover, // عکس رو کامل میزاره داخل دکوراتور قشنگ میشه حتما بزار
                              image: NetworkImage(

                                //چون از کنترلز یک obj به نام recommendedProducts  گرفتیم باید از طریق لیست و index به img دسترسی داشته باشیم
                                APPConstants.BASE_URL+APPConstants.UPLOAD_URL + recommendedProducts.recommendedProductList[index].img!,

                              ),
                            ),
                          ),
                        ),

                        //text section
                        Expanded(//برای اینکه تمام عرض در دسترس با container گرفته شود
                          child: Container(
                              height:Dimensions.getHeight(100) ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.getHeight(20)),
                                  bottomRight: Radius.circular(Dimensions.getHeight(20)),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left:Dimensions.getWidth(10),
                                    right: Dimensions.getWidth(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProducts.recommendedProductList[index].name!),
                                    SizedBox(height: Dimensions.getHeight(10),),
                                    SmallText(text: 'spicy'),
                                    SizedBox(height: Dimensions.getHeight(10),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(icon: Icons.circle_sharp,
                                            text: 'Normal',
                                            iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(icon: Icons.location_on,
                                            text: '1.7Km',
                                            iconColor: AppColors.mainColor),
                                        IconAndTextWidget(icon: Icons.access_time_rounded,
                                            text: '32min',
                                            iconColor: AppColors.iconColor2)
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ],
                    ),

                  ),
                );

              }) : CircularProgressIndicator(color: AppColors.mainColor);
        }),



      ],
    );
  }
  Widget  _buildPageItem (int index, ProductModel popularProduct) { // آرگومان دوم به عنوان index است که object های داخل لیست را اشاره میکند
    Matrix4 matrix = Matrix4.identity();// for scaling   its got(x,y,z)

    if (index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      //setTranslationRaw    MOVES IN X Y AXIS
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0); // اعمال scale و بعد باید اون widget مورد نظر را wrap کنیم توی transform

    }else if (index == _currPageValue.floor() + 1){
      var currScale = _scaleFactor-(_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0); // اعمال scale و بعد باید اون widget مورد نظر را wrap کنیم توی transform

    }else if (index == _currPageValue.floor() - 1){
      var currScale = 1-(_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0); // اعمال scale و بعد باید اون widget مورد نظر را wrap کنیم توی transform

    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1-currScale)/2, 0); // اعمال scale و بعد باید اون widget مورد نظر را wrap کنیم توی transform

    }


    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          /*
          item image
           */
          GestureDetector(
            onTap: (){
              Get.toNamed(RoutesHelper.getPopularFood(index , 'home'));
            },
            child: Container(
              // ,اگر بخوایم ارتفاع خاصی بگیره میزاریمش داخل stack و ارتفاع میدیم چون child کل فضای parent container رو میگیره
              height: _height,
              margin:  EdgeInsets.only(left: Dimensions.getWidth(10) , right: Dimensions.getWidth(10)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.getHeight(30)),
                  color: const Color(0xff69c5df),
                  image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          APPConstants.BASE_URL+APPConstants.UPLOAD_URL + popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          /*
          item info
           */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // ,اگر بخوایم ارتفاع خاصی بگیره میزاریمش داخل stack و ارتفاع میدیم چون child کل فضای parent container رو میگیره
              height: Dimensions.getHeight(120),
              margin:  EdgeInsets.only(left: Dimensions.getWidth(30) , right: Dimensions.getWidth(30) , bottom: Dimensions.getHeight(30)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                  color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5,0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0),
                  )
                ],
              ),
              child: Container(
                padding:  EdgeInsets.only(top: Dimensions.getHeight(10) , left: Dimensions.getWidth(15) , right: Dimensions.getWidth(15)),
                child: AppColumn(text: popularProduct.name!, stars: popularProduct.stars!,),

              ),
            ),
          )
        ],
      ),
    );
  }
}


