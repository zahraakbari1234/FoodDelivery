import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //showing header
          Container(
            child: Container(
              margin:  EdgeInsets.only(top: Dimensions.getHeight(15), bottom: Dimensions.getHeight(15)),
              padding:  EdgeInsets.only(left: Dimensions.getWidth(20) , right: Dimensions.getWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*
                first child
                 */
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                    first
                     */
                       BigText(
                         text: 'Iran',
                         color: AppColors.mainColor,
                       ),
                      /*
                    second
                     */
                      Row(
                        children: [
                          /*
                        first
                         */
                          SmallText(
                            text: 'Tehran',
                            color: Colors.black54,
                          ),
                          /*
                        second
                         */
                          const Icon(Icons.arrow_drop_down_rounded),
                        ],
                      )
                    ],
                  ),
                  /*
                second child
                 */
                  Center(
                    child: Container(
                      width: Dimensions.getWidth(45),
                      height: Dimensions.getHeight(45),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor,
                      ),
                      child:  Icon(Icons.search , color: Colors.white , size: Dimensions.getHeight(24)),
                    ),
                  )
                ],
              ),
            ),
          ),
          //showing body
          const Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          )),


        ],
      ),
    );
  }
}
