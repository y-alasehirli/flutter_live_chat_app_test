import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../const/ui_theme.dart';

class CustomLoadingIndi extends StatelessWidget {
  const CustomLoadingIndi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: const [
            Positioned(
              left: 5,
              top: 5,
              child: SpinKitPouringHourGlassRefined(
                strokeWidth: 0.8,
                size: 30,
                color: UITheme.primaryDarkColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
