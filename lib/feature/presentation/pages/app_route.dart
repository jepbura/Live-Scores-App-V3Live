import 'package:flutter/material.dart';

import 'pages.dart';

class AppRoute {
  AppRoute._();

  //define page route name
  static const String splashScreen = 'splashscreen';
  static const String homeScreen = 'home';
  static const String leagueScreen = 'league';
  static const String detailScreen = 'detail';
  static const String guideScreen = 'guide';

  //define page route
  static Map<String, WidgetBuilder> getRoutes({RouteSettings? settings}) => {
        splashScreen: (_) => const SplashScreenPage(),
        homeScreen: (_) => const HomePage(),
        leagueScreen: (_) => const LeaguePage(),
        guideScreen: (_) => const GuidePage(),
      };
}
