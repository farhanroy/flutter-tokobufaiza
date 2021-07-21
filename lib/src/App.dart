import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/ProductRepository.dart';
import 'utils/Constants.dart';
import 'utils/Route.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ProductRepository>(
            create: (context) => ProductRepository(),
          ),
        ],
        child: MaterialApp(
          title: Constants.APP_NAME,
          theme: ThemeData(
            primaryColor: Color(0xFF6B22DC),
          ),
          onGenerateRoute: RouteService.generateRoute,
          initialRoute: RouteName.SplashScreen,
        ));
  }
}
