import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/sheredpref_helper.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "NotoSerif",
  primarySwatch: defeaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          fontFamily: '',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.black)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      elevation: 20.0),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  ///
   cardColor: HexColor("333739"),
    fontFamily: "NotoSerif",
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: HexColor("333739"),
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backgroundColor: HexColor("333739"),
        
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor('333739'),
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: const IconThemeData(color: Colors.grey)));

Widget defeaultTextFormFiel({
  required TextEditingController textEditingController,
  required String label,
  required IconData prefix,
  required TextInputType type,
  required String? Function(String? val)? validator,
  Function? onchange,
  Function(String)? onSubmit,
  Function? onTap,
  IconData? suffix,
  Function? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: textEditingController,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix),
              )
            : null,
      ),
    );

Widget defeaultButton({
  Color color = Colors.blue,
  double width = double.infinity,
  required var function,
  required String text,
  bool isUperCase = true,
  double radius = 0.0,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defeaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text),
    );

Widget? buildGoTo({required context, required Widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}

Widget? navigatePushAndReplacement({required context, required widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) {
        return false;
      },
    );

Widget myDivider() => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ));

dynamic defeaulttoast({required String message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCESS, WARNING, ERROE }

Color changeToastColor(ToastState state) {
  Color mycolor;
  switch (state) {
    case ToastState.SUCESS:
      mycolor = Colors.green;
      break;
    case ToastState.WARNING:
      mycolor = Colors.amber;
      break;
    case ToastState.ERROE:
      mycolor = Colors.red;
      break;
  }
  return mycolor;
}

void logOut(context) {
  SharedHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

Widget buildListItems({model, context}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      height: 100.0,
      child: Row(children: [
        Container(
          width: 100.0,
          height: 100.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(height: 200.0, image: NetworkImage(model!.image)),
              if (model.discount != 0 )
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.pink,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(50.0))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  color: Colors.black,
                )),
           const Spacer(),
            Row(
              children: [
                Text(
                  "${model.price}}",
                  style: TextStyle(color: defeaultColor),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                if (true)
                  Text(
                    "${model.oldPrice}",
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
               const Spacer(),
                CircleAvatar(
                  radius: 15.0,
                  backgroundColor:
                      CubitHomeLayout.get(context).favoriets[model.id]!
                          ? defeaultColor
                          : Colors.grey,
                  child: IconButton(
                    padding:const  EdgeInsets.all(0.0),
                    onPressed: () {
                      CubitHomeLayout.get(context).changeFavorItes(model.id!);
                    },
                    icon: const  Icon(
                      Icons.favorite_border_outlined,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
      ]),
    ),
  );
}
