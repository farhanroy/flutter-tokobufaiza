import 'package:flutter/material.dart';

import '../modules/home/HomeScreen.dart';
import '../modules/splash/SplashScreen.dart';

class RouteName {
  RouteName._();

  static const String SplashScreen = "/splash";
  static const String HomeScreen = "/";
}

class RouteService {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.SplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteName.HomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
