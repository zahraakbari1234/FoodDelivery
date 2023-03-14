import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/colors.dart';
import '../utils/dimensions.dart';


class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;//حتما باید قبل استفاده initial بشه وقتی late میزاریم
  late String secondHalf;

  bool _isHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > Dimensions.getHeight(150)){
      firstHalf = widget.text.substring( 0 , Dimensions.getHeight(150) );
      secondHalf = widget.text.substring( Dimensions.getHeight(150)+1 , widget.text.length ) ;

    }else{
      firstHalf = widget.text;
      secondHalf = ""; //  باید حتما بزاری که ارور نده وگر نه null باشه ارور میده  چون late  است
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty == true ? SmallText(height:1.8 ,color: AppColors.paraColor,size: Dimensions.getHeight(16) , text: firstHalf) : Column(
        children: [
          SmallText(height:1.8 ,color: AppColors.paraColor,size: Dimensions.getHeight(16),text: _isHidden ? ('$firstHalf...') : (firstHalf + secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                _isHidden = !_isHidden;
              });
            },
            child: Row(
              children: [
                SmallText(
                  text: 'show more',
                  color: AppColors.mainColor,
                ),
                Icon(_isHidden ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
