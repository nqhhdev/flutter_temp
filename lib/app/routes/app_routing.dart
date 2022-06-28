import 'package:flutter/material.dart';
import 'package:flutter_temp_by_nqh/presentation/home_screen/home_route.dart';
import 'package:flutter_temp_by_nqh/presentation/splash_screen/splash_route.dart';

enum RouteDefine {
  ///ADD ROUTE FOR EXAMPLE
  splashScreen,
  homeScreen,
  listUserScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      ///ADD ROUTE
      RouteDefine.splashScreen.name: (_) => SplashRoute.route,
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
