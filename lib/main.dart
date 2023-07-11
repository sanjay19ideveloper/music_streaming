import 'package:flutter/material.dart';
import 'package:music/music.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:MusicScreen()
      );
      }
    
  //     home: WaveSlider( duration: 60,
  // callbackStart: (double duration) {
  //   // Callback start logic here
  // },
  // callbackEnd: (double duration) {
  //   // Callback end logic here
  // },
  //   ));
  // }
}

