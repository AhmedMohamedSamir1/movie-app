import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';




ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('21232E'),
    primarySwatch: Colors.blue,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange
    ),

    appBarTheme: const AppBarTheme(

      backgroundColor: Colors.blue,
      elevation: 0,
      iconTheme: IconThemeData(
          color: Colors.black
      ),


      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          statusBarIconBrightness: Brightness.light
      ),
      titleTextStyle: TextStyle(
          color: Colors.black
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 30,
        backgroundColor: Colors.white
    ),

    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    ),

);

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: Colors.blue,

    appBarTheme: AppBarTheme(

      backgroundColor: HexColor('333739'),
      elevation: 0,
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      backwardsCompatibility: false, // false enable control of status bar
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light
      ),
      titleTextStyle: const TextStyle(
          color: Colors.white
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      elevation: 30,
      backgroundColor: HexColor('333739'),
    ),

    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white
        )
    )
);

