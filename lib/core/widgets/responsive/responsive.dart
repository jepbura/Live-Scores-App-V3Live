import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget wear;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.wear,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isWare, isMobile, isTablet, isDesktop helep us later
  static bool isWare(BuildContext context) => MediaQuery.of(context).size.width < 300;

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850 && MediaQuery.of(context).size.width >= 300;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width < 1100 && size.width >= 850) {
      return tablet;
    }
    // If width it less then 850 and more then 300 we consider it as mobile
    else if (size.width < 850 && size.width >= 300) {
      return mobile;
    }
    // Or less then that we called it wear
    else {
      return wear;
    }
  }
}
