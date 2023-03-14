import 'package:get/get.dart';

class Dimensions {

  static double screenHeight = Get.height;

  static double screenWidth = Get.width;

  static getHeight(double pixels){
    double x  =  screenHeight/pixels;
    return screenHeight/x;
  }

  static getWidth(double pixels){
    double x  =  screenWidth/pixels;
    return screenWidth/x;
  }

  //static double image350 = screenHeight/2.41; //350

/*
  static getScreenHeight(){
    return Get.height;
  }

    static double pageView = screenHeight/2.63; //320
  static double pageViewContainer = screenHeight/3.84;  //220
  static double pageViewTextContainer = screenHeight/7.03; //120

  static getScreenWidth(){
    return Get.width;
  }
*/

}