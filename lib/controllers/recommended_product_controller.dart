import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo; //  برای اینکه به repository آن دسترسی داشته باشیم instance گرفتیم
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = []; //دیتاهایی که repo برمیگردونه رو توی این لیست ذخیره میکنیم
  List<dynamic> get recommendedProductList => _recommendedProductList;//چون _ داره private هست
  // وقتی get  استفاده میکنیم از اون متغییر خارج از این کلاس هم میشه استفاده کرد
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){ //successful
      _recommendedProductList = []; // اگر این خط را ننویسیم دیتا چندبار تکرار میشه چون این تابع چند بار فراخوانی میشه
      _recommendedProductList.addAll(product.fromJson(response.body).products); // we need to convert json data to model
      _isLoaded = true ;
      update(); // SetState() مثل
    }else{


    }
  }
}