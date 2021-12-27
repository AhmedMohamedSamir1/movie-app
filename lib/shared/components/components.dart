
// ignore_for_file: non_constant_identifier_names

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animations/loading_animations.dart';

//-------------start material button ---------------------
Widget defaultMaterialButton({
  double btnWidth = double.infinity,
  Color btnColor = Colors.blue,
  Color textColor = Colors.white,
  double fontSize = 18,

  double radius = 0,
  bool isUpperCase = true,

  required  Function()? onPressed,
  required String text,

  List<Color>? gradientColorsList,
  Color boxShadowColor = Colors.grey,
})
{
  return     Container(
              width: btnWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: btnColor,
                gradient: gradientColorsList!=null ? LinearGradient(colors:gradientColorsList) : null ,
                  boxShadow:  [
                    BoxShadow(
                      color: boxShadowColor.withOpacity(0.35),
                      spreadRadius: 3,
                      blurRadius:5,
                      offset: const Offset(0, 2),
                    )
                  ]
              ),

              child: MaterialButton(
              onPressed: onPressed,
              child: Text(
                isUpperCase? text.toUpperCase(): text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize
                ),
              ),
            ),
          );
}
//----------------- end material button -----------------------

//---------------- start elevated button------------------

Widget myElevatedBtn({
  required IconData icon,
  required  Function()? onPressed,
  required Widget widget,
  Color backroundColor = Colors.blue,
})
{
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: widget,

      style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(backroundColor),

),

);
}

//------------------ end elevated button----------------------

//---------------start text button ------------------------

Widget defaultTextButton({
  required Function()? onClick,
  required String text,
})
{
  return TextButton(
      onPressed: onClick,
      child: Text(text.toUpperCase())
  );
}
//---------------- end text button ------------------

//---------------- start TextFormField ------------------
Widget defaultTextFormField(
{
  required TextEditingController fieldController,
  required TextInputType inputType,
  bool obscureText = false,

  Function(String)? onSubmit,
  Function(String)? onChange,

  required  String? Function(String?)? validator,

  required String labelText,
  required IconData prefixIcon,

  IconData? suffixIcon,
  Function()? suffixClicked,

  Function()? onTab,

  bool readOnly = false,

  Color? fieldColor,

  double borderRadius = 0,

  double elevation = 0,

  int maxLines = 1,

}) =>Material(

  elevation: elevation,
  shadowColor: Colors.grey,
  borderRadius: BorderRadius.circular(borderRadius),

  child:   TextFormField(

    controller: fieldController,

    keyboardType: inputType,

    obscureText: obscureText,

    onFieldSubmitted: onSubmit,

    onChanged:onChange,

    validator: validator,

    readOnly: readOnly,

    onTap: onTab,

    decoration: InputDecoration(


      hintText: labelText,

      //labelText: labelText,

      prefixIcon: Icon(prefixIcon),

      suffixIcon: IconButton(
        onPressed: suffixClicked,
        icon: Icon(
           suffixIcon,
        ),
      ),

      filled: fieldColor!=null ? true : false,

      fillColor: fieldColor,

      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),

    ),
    maxLines: maxLines,


  ),
);

//---------------- end TextFormField ------------------



//----------------------start divider -----------------
Widget myDivider({
  double height = 2,
  double width = double.infinity,
  Color dividerColor = Colors.grey,
})
{
  return Container(
    height: height,
    width: width,
    color: Colors.grey,
  );
}
//----------------------end divider --------------------






//--------------start conditional builder ---------------

// Widget defaultConditionalBuilder({
//   required BuildContext context,
//   required bool Function(BuildContext context) conditionBuilder,
//   required Widget widgetBuilder,
//  // Widget?  fallbackBuilderWidget,
//
// })
// {
//   return Conditional.single(
//       context: context,
//       conditionBuilder: conditionBuilder,
//       widgetBuilder: (BuildContext context) => widgetBuilder,
//       fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white,),) //if condition false
//   );
// }

//--------------end conditional builder---------------




//--------------start navigation without finish---------------
void navigateTo(context, widget)
{
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context){
            return widget;
          }
      )
  );
}
//-------------- end navigation without finish ---------------


//---------------start navigation with finish------------
void navigateAndFinish(context, widget)
{
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => widget
      ),
       (route) => false
  );
}
//---------------end navigation with finish------------


//---------start flutter toast--------------------

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void toastMessage({
  required String textMessage,
  required ToastStates toastState,

  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,

  int toast_time_in_IOS_WEB = 1,
  Color textColor =  Colors.white,
  double fontSize = 16.0,

})
{
   Fluttertoast.showToast(
      msg: textMessage,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: toast_time_in_IOS_WEB,
      backgroundColor: chooseToastColor(toastState),
      textColor: textColor,
      fontSize: fontSize
  );
}
//---------end flutter toast-----------------



//--------- start carousel slider ----------
//
// Widget myCarouselSlider({
//   required List<Widget> Widgets,
//   double?height,
//   int initialPage = 0,
//   bool enableInfiniteScroll = true,
//   bool reverse = false,
//   bool autoPlay = true,
//   int autoPlayDurationInSec = 3,
//   int autoPlayAnimatioDurationInSec = 1,
//   Curve autoPlayCurve = Curves.fastOutSlowIn,
//   Axis scrollDirection = Axis.horizontal,
//   double viewportFraction = 0.85
// })
// {
//   return CarouselSlider(
//       items: Widgets,
//
//       options: CarouselOptions(
//           height: height,
//           initialPage: initialPage,
//           enableInfiniteScroll: enableInfiniteScroll,
//           reverse: reverse,
//           autoPlay: autoPlay,
//           autoPlayInterval: Duration(seconds: autoPlayDurationInSec),
//           autoPlayAnimationDuration: Duration(seconds: autoPlayAnimatioDurationInSec),
//           autoPlayCurve: autoPlayCurve, // transition shape
//           scrollDirection: scrollDirection,
//           viewportFraction: viewportFraction  // 1 view all image
//       )
//   );
// }

//--------  start carousel slider ----------


//--------- start gridView-------------
// Widget defaultGridView({
//   double mainAxisSpacing = 1,
//   double crossAxisSpacing = 1,
//   required int crossAxisCount,
//   double cellWidth = 1,
//   double cellHeight = 1,
//   required List<Widget> widgets,
//   bool preventScroll = true,
//   Color background =  Colors.grey
// })
// {
//   return  Container(
//     color: background,
//     child: GridView.count(
//
//
//       crossAxisCount: 2,   // grid row consist of 2
//       mainAxisSpacing: mainAxisSpacing,
//       crossAxisSpacing: crossAxisSpacing,
//       children: widgets,
//       childAspectRatio: cellWidth / cellHeight,    // width / height
//       shrinkWrap: preventScroll,
//       physics:preventScroll? NeverScrollableScrollPhysics():null,
//
//     ),
//   );
// }
//--------- end gridView--------------


//----start appBar-----------
// PreferredSizeWidget defaultAppBar({
//   required BuildContext context,
//   String? title,
//   List<Widget>? actions,
//   double? titleSpacing,
// })
// {
//   return AppBar(
//     leading: IconButton(
//       onPressed: (){
//         Navigator.pop(context);
//       },
//       icon: Icon(IconBroken.Arrow___Left_2),
//     ),
//     title: Text(title??''),
//     titleSpacing: titleSpacing,
//     actions: actions,
//   );
//}
//----end appBar-----------


//--------------------

Widget animatedLoading({
  Color loadingColor = Colors.blue,
  double? borderSize,
  double size = 80,
  required Duration duration,

})
{
  return LoadingBouncingLine.circle(
    backgroundColor: loadingColor,
    size: size,
    duration: duration,
  );
}
//---------------------


//--------------------------------

Widget dropDownSearch({

  required List<String> dropDownList,
  required String? hint,
  double radius = 0,
  required GlobalKey<DropdownSearchState<String>> dropDownSearchKey,
  required String? selectedItem,
  void Function(String?)? onChanged,
  required String? Function(String?)? validator,

})
{
  return    DropdownSearch(
    key: dropDownSearchKey,
    //mode of dropdown
    mode: Mode.DIALOG,
    //to show search box
    showSearchBox: true,
    items: dropDownList,

    dropdownSearchDecoration:  InputDecoration(
      hintText: hint,

      border:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    ),
    validator: validator,
    onChanged: onChanged,

    //show selected item
    selectedItem: selectedItem,

  );
}

//----------------------------


//------------- start outlined button----------------

Widget defaultOutLinedButton({
  double? btnHeight,
  Color btnTxtColor = Colors.blue,
  Color borderColor = Colors.blue,
  double borderWidth = 2,
  required String btnText,
  void Function()? onClick,
  TextStyle? txtStyle,
  })
{

  return SizedBox(
    height: btnHeight,
    child: OutlinedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(btnTxtColor),
        side: MaterialStateProperty.all(BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: Text(
          btnText,
        style: txtStyle,
      ),
      onPressed: onClick,
    ),
  );

}
//------------- start outlined button--------------


