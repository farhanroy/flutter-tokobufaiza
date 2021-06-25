import 'package:flutter/material.dart';

import 'utils/Constants.dart';
import 'utils/Route.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteService.generateRoute,
      initialRoute: RouteName.SplashScreen,
    );
  }
}
