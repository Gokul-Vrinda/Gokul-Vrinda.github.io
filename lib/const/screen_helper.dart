import 'package:flutter/material.dart';

class ScreenHelper {
  // Screen size check cheyyanulla helper methods
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static Size screenSize(BuildContext context) =>
      MediaQuery.of(context).size;
}