import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;



  Future<void> _loadResources() async{

    //to find controller in GETX
    //چون load بعد از getmaterialaap تعریف شده توی مموری نمیمونه پس getmaterialapp در main را دور getbuilder میپیچیم
    Get.find<PopularProductController>().getpopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this , duration: const Duration(seconds: 5) )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
   _loadResources();
    Timer( // wait till seconds pass and then do sth
        Duration(seconds: 5),
            ()=> Get.offNamed(RoutesHelper.getInitial())
    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset('assets/images/logo1.png'
          ))),

        ],
      ),
    );
  }
}
