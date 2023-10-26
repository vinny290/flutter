import 'package:flutter/material.dart';
import 'package:testik_app/db/database.dart';
import 'package:testik_app/widgets/widgets.dart';

import '../screens.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 61, 61),
      appBar: CustomAppBar(title: 'ВМузыке'),
      bottomNavigationBar: CustomNavBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Самые',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Популярные',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '960 плейлистов',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: TrackWidget(refresh),
                ),
                CircleTrackWidget(
                  song: newRelease,
                  title: 'Новинки',
                  subtitle: '345 песен',
                  notifyParent: refresh,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PlayerHome(currentSong),
          )
        ],
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}
