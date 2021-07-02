import 'package:flutter/material.dart';

import '../modules/product/ProductModule.dart';
import '../modules/home/HomeScreen.dart';
import '../modules/splash/SplashScreen.dart';

class RouteName {
  RouteName._();

  static const String SplashScreen = "/splash";
  static const String HomeScreen = "/";
  static const String DashboardProductScreen = "/product/dashboard";
  static const String AddProductScreen = "/product/add";
  static const String DetailProductScreen = "/product/detail";
  static const String SettingScreen = "/setting";
}

class RouteService {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.SplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteName.HomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.DashboardProductScreen:
        return MaterialPageRoute(builder: (_) => DashboardProductScreen());
      case RouteName.AddProductScreen:
        return MaterialPageRoute(builder: (_) => AddProductScreen());
      case RouteName.DetailProductScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.SplashScreen:
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
