import 'package:flutter/material.dart';
import 'package:testik_app/db/database.dart';
import 'package:testik_app/widgets/widgets.dart';
import 'package:testik_app/screens/screens.dart';

class PlaylistScreen extends StatefulWidget {
  static const String routeName = '/playlist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => PlaylistScreen(),
    );
  }

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 61, 61),
      appBar: CustomAppBar(title: 'Плейлист'),
      bottomNavigationBar: CustomNavBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleTrackWidget(
                  song: newRelease,
                  title: 'Твой плейлист',
                  subtitle: '345 песен',
                  notifyParent: refresh,
                ),
                SizedBox(
                  height: 130,
                )
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
