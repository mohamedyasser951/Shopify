import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/component/constants.dart';




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