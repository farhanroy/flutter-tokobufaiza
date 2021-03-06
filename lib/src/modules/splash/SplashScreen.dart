import 'package:flutter/material.dart';

import '../../utils/Route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushNamed(context, RouteName.HomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
            'assets/images/icon.png',
          width: size.width/3,
          height: size.width/3,
        ),
      ),
    );
  }
}
