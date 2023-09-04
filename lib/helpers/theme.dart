import 'package:flutter/material.dart';

import '../utilities/colors.dart';

const seedColor = primaryColor;
const seedColorDark = primaryColorDark;

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkmode ? primaryColorDark : primaryColor,
          foregroundColor: isDarkmode ? Colors.white : Colors.black,
          titleTextStyle: TextStyle(
            color: isDarkmode ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: isDarkmode ? Colors.white : Colors.black,
          ),
        ),
        colorSchemeSeed: isDarkmode ? primaryColorDark : primaryColor,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        listTileTheme: ListTileThemeData(
          iconColor: isDarkmode ? primaryColorDark : primaryColor,
        ),
        primaryColorDark: primaryColor,
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(
            color: isDarkmode ? Colors.black : Colors.white,
          ),
        ),
      );
}
