import 'package:flutter/material.dart';
import 'package:testik_app/db/database.dart';
import 'package:testik_app/screens/screens.dart';

Song currentSong = Song(
  name: 'title',
  singer: 'singer',
  image: 'assets/song1.jpg',
  duration: 100,
  color: Colors.black,
);
double currentSlider = 0;

class PlayerHome extends StatefulWidget {
  final Song song;
  PlayerHome(this.song);

  @override
  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, _, __) => MusicPlayer(widget.song)));
      },
      child: Container(
        height: 108,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color.fromARGB(147, 0, 0, 0),
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'image',
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.song.image),
                        radius: 22,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.song.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.song.singer,
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.pause, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Icon(Icons.skip_next_outlined,
                        color: Colors.white, size: 30),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Duration(seconds: currentSlider.toInt())
                      .toString()
                      .split('.')[0]
                      .substring(2),
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: currentSlider,
                      max: widget.song.duration.toDouble(),
                      min: 0,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.white,
                      onChanged: (val) {
                        setState(() {
                          currentSlider = val;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  Duration(seconds: widget.song.duration)
                      .toString()
                      .split('.')[0]
                      .substring(2),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
