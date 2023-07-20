import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UITheme {
  //  Colors
  static const Color backgroundColor = Color.fromRGBO(243, 249, 255, 1);
  static const Color primaryColor = Color.fromRGBO(123, 125, 159, 1);
  static const Color secondaryColor = Color.fromRGBO(135, 253, 171, 1);
  static const Color backgroundColorDark = Color.fromRGBO(6, 17, 59, 1);
  static const Color cardBackgroundColor = Color.fromRGBO(246, 248, 254, 1);
  static const Color primaryDarkColor = Color.fromRGBO(99, 101, 128, 1);
  static Color errorColor = Colors.red.shade800;

  //SystemUIOverlay - StatusBar Theme
  static const SystemUiOverlayStyle statusBarTheme = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);

  //  ThemeData
  static ThemeData mainThemeData = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: cardBackgroundColor,
      colorScheme: ColorScheme(
          primary: backgroundColor,
          primaryVariant: backgroundColorDark,
          secondary: primaryColor,
          secondaryVariant: backgroundColor,
          surface: cardBackgroundColor,
          background: backgroundColor,
          error: errorColor,
          onPrimary: primaryDarkColor,
          onSecondary: cardBackgroundColor,
          onSurface: primaryDarkColor,
          onBackground: primaryDarkColor,
          onError: backgroundColor,
          brightness: Brightness.light),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: primaryColor));

  //  TextStyle
  static const TextStyle headtitleMainStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: primaryDarkColor);

  // Shape
  static BorderRadius radiusCircular = BorderRadius.circular(15);

  // CardShapeBorder
  static RoundedRectangleBorder cardShape =
      RoundedRectangleBorder(borderRadius: radiusCircular);

  //  TextField - InputDecoration
  static InputDecoration textFormFieldDecoration(String label) {
    return InputDecoration(
        label: Text(
          label,
          style: const TextStyle(color: UITheme.primaryDarkColor),
        ),
        filled: true,
        fillColor: UITheme.backgroundColor,
        border: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: UITheme.radiusCircular));
  }

  //  AlertErrorDialog Function
  static void alertErrorDialog(BuildContext context, Exception e) {
    showDialog(
        barrierColor: UITheme.errorColor.withOpacity(0.2),
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: UITheme.radiusCircular),
            content: Text(
              e.toString(),
            )));
  }

  //  AlertButtonNoTitleDialog Function
  static void alertButtonNoTitleDialog(
      BuildContext context, List<Widget> list) {
    showDialog(
        barrierColor: UITheme.primaryColor.withOpacity(0.2),
        context: context,
        builder: (context) => AlertDialog(
              actions: list,
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              shape:
                  RoundedRectangleBorder(borderRadius: UITheme.radiusCircular),
            ));
  }

  // DotNavigationBar Items
  static List<DotNavigationBarItem> bottomNavigationItems = [
    DotNavigationBarItem(icon: const Icon(Icons.group)),
    DotNavigationBarItem(
        icon: const Icon(CupertinoIcons.bubble_left_bubble_right_fill)),
    DotNavigationBarItem(icon: const Icon(Icons.person_rounded)),
  ];
}
