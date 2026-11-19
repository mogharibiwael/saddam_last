import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "PlayfairDisplay",
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22, color: AppColor.black),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
    headlineLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
    bodySmall: TextStyle(
        height: 2,
        color: AppColor.black,
        fontWeight: FontWeight.bold,
        fontSize: 14),
    bodyMedium: TextStyle(height: 2, color: AppColor.black, fontSize: 14),
    bodyLarge: TextStyle(height: 2, color: AppColor.black, fontSize: 16),
  ),
  iconTheme: const IconThemeData(
    color: AppColor.black,
  ),
  primarySwatch: Colors.blue,
);

ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: AppColor.white,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: AppColor.black,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: AppColor.white,
    ),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColor.black,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColor.black,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      height: 2,
      color: AppColor.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColor.black,
  ),
  primarySwatch: Colors.blue,
);
