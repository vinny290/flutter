import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => UserScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Аккаунт'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
