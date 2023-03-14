import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backGroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  AppIcon({Key? key, required this.icon,
    this.backGroundColor = const Color(0xfffcf4e4),
    this.iconColor = const Color(0xff756d54),
    this.size = 40 ,
    this.iconSize = 16
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2), //  ایجاد دایره
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
