
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final bool isPlaylist;
  // final LoopMode loopMode;
  // final VoidCallback onStop;
  // final VoidCallback toggleLoop;
  final VoidCallback onPlay;
  // final VoidCallback onNext;
  // final VoidCallback onPrevious;

  const PlayingControls({
    required this.isPlaying,
    required this.isPlaylist,
    // required this.loopMode,
    // required this.onStop,
    // required this.toggleLoop,
   required this.onPlay,
    // required this.onNext,
    // required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(
        //   onPressed: onPrevious,
        //   icon: Icon(Icons.skip_previous),
        // ),
        IconButton(
          onPressed: onPlay,
          icon: isPlaying ? Icon(Icons.pause,size:15) : Icon(Icons.play_arrow,size:15),
        ),
        // IconButton(
        //   onPressed: onNext,
        //   icon: Icon(Icons.skip_next),
        // ),
        // if (isPlaylist)
        //   IconButton(
        //     onPressed: toggleLoop,
        //     icon: Icon(Icons.repeat),
        //     // loopMode == LoopMode.none
        //     //     ? Icon(Icons.repeat)
        //     //     : Icon(Icons.repeat_one),
        //   ),
        // IconButton(
        //   onPressed: onStop,
        //   icon: Icon(Icons.stop),
        // ),
      ],
    );
  }
}

class LoopMode {
}
