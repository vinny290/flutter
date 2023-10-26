import 'package:flutter/material.dart';

class AudioInfo extends StatelessWidget {
  const AudioInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/music.png',
          width: 200,
        ),
        const SizedBox(height: 15),
        const Text(
          'Туман',
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 12),
        const Text(
          'Джамман',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
