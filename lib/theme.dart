
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(

  colorScheme: ColorScheme.light(
    shadow: Colors.grey.withAlpha(150),
    onPrimary: Colors.black, //! TEXT
    primaryContainer: Colors.green.shade100, //! container rengi
    outline: Colors.green.shade100, //! border color
    onSecondary: Colors.white, //! BottomSheet
    

    

    onPrimaryFixed: Color.fromRGBO(255, 255, 255, 1), //! scafold bacground color 1
    onSecondaryFixed: Color.fromRGBO(230, 231, 229, 1), //! scafold bacground color 2


    onTertiary: Colors.white
    
    
  ),

  scaffoldBackgroundColor: Colors.white,
  //colorSchemeSeed: Colors.deepPurple, // Tüm temayı bu renkten türetir
  brightness: Brightness.light,
  useMaterial3: true,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),

  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.purple)
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //backgroundColor: Colors.white,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey
  ),
);





final ThemeData darkTheme = ThemeData(

  colorScheme: ColorScheme.dark(
    shadow: Colors.green.withAlpha(150),
    onPrimary: Colors.white, //! TEXT
    primaryContainer: Color.fromRGBO(43, 49, 65, 1), //! container rengi
    outline: Colors.green.shade700, //! border rengi
    onSecondary: Colors.black, //! BottomSheet

    
    onPrimaryFixed: Color.fromRGBO(81, 87, 105, 1), //! scafold bacground color 1
    onSecondaryFixed: Color.fromRGBO(30, 36, 49, 1), //! scafold bacground color 2

    onTertiary: Color.fromRGBO(31, 39, 56, 1),
    
  ),
  scaffoldBackgroundColor: Colors.black,
  //colorSchemeSeed: Colors.deepPurple,
  brightness: Brightness.dark,
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.blue)
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.amber
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //backgroundColor: Colors.black,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey
  ),
);