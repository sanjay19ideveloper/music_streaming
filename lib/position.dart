import 'package:flutter/material.dart';


class PositionSeekWidget extends StatelessWidget {
  final Duration currentPosition;
  final Duration duration;
  final ValueChanged<Duration> seekTo;

  const PositionSeekWidget({
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${formatDuration(currentPosition)} / ${formatDuration(duration)}',
        ),
        Slider(
          value: currentPosition.inMilliseconds.toDouble(),
          min: 0.0,
          max: duration.inMilliseconds.toDouble(),
          onChanged: (value) {
            final seekDuration = Duration(milliseconds: value.toInt());
            seekTo(seekDuration);
          },
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
