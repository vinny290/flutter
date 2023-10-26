import 'package:flutter/material.dart';
import 'package:testik_app/widgets/widgets.dart';

class PlaylistScreen extends StatelessWidget {
  static const String routeName = '/playlist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => PlaylistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Плейлисты'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
