import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Ca {
  static const Color primary = Color(0xFF0560FA);
  static const Color success = Color(0xFF35B369);
  static const Color secondary = Color(0xFFEC8000);
  static const Color yellow = Color(0xFFEBBC2E);
  static const Color error = Color(0xFFED3A3A);
  static const Color text4 = Color(0xFF3A3A3A);
  static const Color text3 = Color(0xFF141414);
  static const Color gray1 = Color(0xFFCFCFCF);
  static const Color gray2 = Color(0xFFA7A7A7);

  static const Color prishade1 = Color(0xFF000D1D);
  static const Color prishade2 = Color(0xFF001B3B);
}

abstract class Fa {
  static final TextStyle primary_700_24 = GoogleFonts.roboto(
      fontSize: 24.sp, fontWeight: FontWeight.w700, color: Ca.primary);

  static final TextStyle text4_400_16 = GoogleFonts.roboto(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: Ca.text4);

  static final TextStyle text4_400_12 = GoogleFonts.roboto(
      fontSize: 12.sp, fontWeight: FontWeight.w400, color: Ca.text4);

  static final TextStyle text4_500_14 = GoogleFonts.roboto(
      fontSize: 14.sp, fontWeight: FontWeight.w500, color: Ca.text4);

  static final TextStyle text4_600_14 = GoogleFonts.roboto(
      fontSize: 14.sp, fontWeight: FontWeight.w600, color: Ca.text4);

  static final TextStyle text4_500_16 = GoogleFonts.roboto(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: Ca.text4);

  static final TextStyle gray2_500_14 = GoogleFonts.roboto(
      fontSize: 14.sp, fontWeight: FontWeight.w500, color: Ca.gray2);

  static final TextStyle gray2_500_16 = GoogleFonts.roboto(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: Ca.gray2);

  static final TextStyle gray2_500_12 = GoogleFonts.roboto(
      fontSize: 12.sp, fontWeight: FontWeight.w500, color: Ca.gray2);

  static final TextStyle gray2_400_14 = GoogleFonts.roboto(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: Ca.gray2);

  static final TextStyle gray2_400_12 = GoogleFonts.roboto(
      fontSize: 12.sp, fontWeight: FontWeight.w400, color: Ca.gray2);

  static final TextStyle gray1_400_12 = GoogleFonts.roboto(
      fontSize: 12.sp, fontWeight: FontWeight.w400, color: Ca.gray1);

  static final TextStyle gray1_500_14 = GoogleFonts.roboto(
      fontSize: 14.sp, fontWeight: FontWeight.w500, color: Ca.gray1);

  static final TextStyle yellow_400_12 = GoogleFonts.roboto(
      fontSize: 12.sp, fontWeight: FontWeight.w400, color: Ca.yellow);
}
