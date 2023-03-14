import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final int stars;
  const AppColumn({Key? key, required this.text, required this.stars, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,
          size: Dimensions.getHeight(26),
        ),
        SizedBox(height: Dimensions.getHeight(10)),
        /*
          rating section
         */
        Row(
          children: [
            Wrap(
              children: List.generate(stars, (index) => Icon(Icons.star , color: AppColors.mainColor, size:Dimensions.getHeight(15),)),
            ),
            SizedBox(width: Dimensions.getWidth(10)),
            SmallText(text: '4.5'),
            SizedBox(width: Dimensions.getWidth(10)),
            SmallText(text: '1287'),
            SizedBox(width: Dimensions.getWidth(10)),
            SmallText(text: 'comments'),
          ],
        ),
        SizedBox(height: Dimensions.getHeight(20)),
        /*
                    icon and text section
                     */
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
    );
  }
}
