import 'package:flutter/material.dart';
import 'package:taskati_dk_4_11/core/utils/colors.dart';

TextStyle getHeadlineStyle(
    {double fontSize = 18, FontWeight fontWeight = FontWeight.bold}) {
  return TextStyle(
    color: AppColors.primaryColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle getTitleStyle(
    {Color color = Colors.black,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.bold}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle getSubTitleStyle(
    {Color color = Colors.black,
    double fontSize = 16,
  FontWeight  fontWeight = FontWeight.normal}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle getSmallStyle({Color color = Colors.grey, double fontSize = 14}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
  );
}
