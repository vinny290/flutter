import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class LoveScreen extends StatelessWidget {
  static const String routeName = '/love';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoveScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Избранное'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
