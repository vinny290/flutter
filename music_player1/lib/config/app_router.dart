import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();

      case HomeScreen.routeName:
        return HomeScreen.route();
      case PlaylistScreen.routeName:
        return PlaylistScreen.route();
      case UserScreen.routeName:
        return UserScreen.route();
      case LoveScreen.routeName:
        return LoveScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Error')),
      ),
    );
  }
}
