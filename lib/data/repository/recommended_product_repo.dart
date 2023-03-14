import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;// از apiclient یک instance میگیریم که به توابع داخلش از اینجا دسترسی داشته باشیم
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async{ // از سرور response  دریافت میشود , از controller دریافت و در آنجا پردازش میشود
    return await apiClient.getData(APPConstants.RECOMMENDED_PRODUCT_URI); // صدا زدن get method از کلاس apiClient
  }
}