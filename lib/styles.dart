import 'package:flutter/cupertino.dart';

class LightColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = Color(0xff1d2635);
  static const Color subTitleTextColor = Color(0xff797878);

  static const Color skyBlue = Color(0xff2890c8);
  static const Color lightBlue = Color(0xff5c3dff);

  static const Color orange = Color(0xffE65829);
  static const Color red = Color(0xffF72804);

  static const Color lightGrey = Color(0xffE1E2E4);
  static const Color grey = Color(0xffA1A3A6);
  static const Color darkgrey = Color(0xff747F8F);

  static const Color iconColor = Color(0xffa8a09b);
  static const Color yellowColor = Color(0xfffbba01);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);
}

class AppTheme {
  const AppTheme();
  static CupertinoThemeData lightTheme = const CupertinoThemeData(
    scaffoldBackgroundColor: LightColor.background,
    primaryColor: LightColor.background,
    // cardTheme: CardTheme(color: LightColor.background),
    textTheme: CupertinoTextThemeData(),
    // iconTheme: IconThemeData(color: LightColor.iconColor),
    barBackgroundColor: LightColor.background,
    // dividerColor: LightColor.lightGrey,
    // primaryTextTheme: TextTheme(
    //   bodyText1: TextStyle(color: LightColor.titleTextColor),
    // ),
  );

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
