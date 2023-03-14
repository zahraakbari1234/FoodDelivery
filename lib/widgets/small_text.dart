import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  SmallText({Key? key, required this.text,
    this.color = const Color(0xfffccc7c5),
    this.size  = 0 ,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.getHeight(12) : size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        height: height ,
      ),
    );
  }
}
