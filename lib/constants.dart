import 'package:flutter/material.dart';

Color kPrimaryColor = Color(0xff5C01D0);
Color kAccentColor = Color(0xff5C01D0);
Color kTwoCurvesColor = Color(0xff8A1AE6);
Color kOneCurveColor = Color(0xffAA2AC9);
Color kDateCardColor = Color(0xffAA2AE2);

int kNumDays = 7;

MaterialColor kSwatchColor = MaterialColor(0xff5C01D0, color);

Map<int, Color> color = {
  50: Color.fromRGBO(4, 131, 184, .1),
  100: Color.fromRGBO(4, 131, 184, .2),
  200: Color.fromRGBO(4, 131, 184, .3),
  300: Color.fromRGBO(4, 131, 184, .4),
  400: Color.fromRGBO(4, 131, 184, .5),
  500: Color.fromRGBO(4, 131, 184, .6),
  600: Color.fromRGBO(4, 131, 184, .7),
  700: Color.fromRGBO(4, 131, 184, .8),
  800: Color.fromRGBO(4, 131, 184, .9),
  900: Color.fromRGBO(4, 131, 184, 1),
};

InputDecoration kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(30, 19, 20, 19),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey[400]!.withOpacity(0.8),
    ),
    borderRadius: BorderRadius.circular(18),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(
      width: 1.5,
      color: kPrimaryColor,
    ),
  ),
  hintText: '\$50',
  fillColor: Colors.grey[200]!.withOpacity(0.4),
  filled: true,
);

TextStyle kTextFieldTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
);
