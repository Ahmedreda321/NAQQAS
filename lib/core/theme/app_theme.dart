import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.backgroundColor,
        fontFamily: 'InstrumentSans',
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.black),
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.primaryColor,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            elevation: 0,
            minimumSize: Size(double.infinity, 40.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'InstrumentSans',
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.white),
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.grayColor,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            elevation: 0,
            minimumSize: Size(double.infinity, 40.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      );
}
