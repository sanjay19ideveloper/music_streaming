import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music/playing_control.dart';
import 'package:music/wave_slider.dart';


class SongsSelector extends StatefulWidget {
  final List<Audio> audios;
  final Playing? playing;
  final ValueChanged<Audio> onSelected;
  final ValueChanged<List<Audio>> onPlaylistSelected;
  final AssetsAudioPlayer assetsAudioPlayer;
final String searchQuery;




  const SongsSelector({
    required this.audios,
    required this.onSelected,
    required this.onPlaylistSelected,
    this.playing,
    required this.assetsAudioPlayer,
    required this.searchQuery,
  });

  @override
  State<SongsSelector> createState() => _SongsSelectorState();
}

class _SongsSelectorState extends State<SongsSelector> {
  
  List<Audio> filteredAudios = [];
  Audio? currentlyPlaying;
   @override
  void initState() {
    super.initState();
    filterAudios();
    currentlyPlaying = widget.playing?.audio as Audio?;
  }
void filterAudios() {
    setState(() {
      if (widget.searchQuery.isEmpty) {
        filteredAudios = widget.audios;
      } else {
        filteredAudios = widget.audios.where((audio) {
          final title = audio.metas.title?.toLowerCase();
          final artist = audio.metas.artist?.toLowerCase();
          final query = widget.searchQuery.toLowerCase();
          return title!.contains(query) || artist!.contains(query);
        }).toList();
      }
    });
  }
  @override
  void didUpdateWidget(SongsSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      filterAudios();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.audios.length,
          itemBuilder: (context, index) {
            final audio = widget.audios[index];

            
            return ListTile(
                leading: Image.network(audio.metas.image?.path ?? ''),
                title: Text('${audio.metas.title}'),
                subtitle: Text('${audio.metas.artist}'),
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => WaveSlider(duration: 60,
  callbackStart: (double duration) {
    // Callback start logic here
  },
  callbackEnd: (double duration) {
    // Callback end logic here
  },
    ))));
                },

                trailing: Container(
decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, 
                ),
                  // color: Colors.red,
                  height: 50,
                  width : 60,
                  child: Column(
                          children: <Widget>[
                            widget.assetsAudioPlayer.builderLoopMode(
                              builder: (context, loopMode) {
                                return PlayerBuilder.isPlaying(
                                    player: widget.assetsAudioPlayer,
                                    builder: (context, isPlaying) {
                                      

                                      return PlayingControls(
                                        // loopMode: loopMode,
                                        isPlaying: isPlaying,
                                        isPlaylist: true,
                                        // onStop: () {
                                        //   assetsAudioPlayer.stop();
                                        // },
                                        // toggleLoop: () {
                                        //   assetsAudioPlayer.toggleLoop();
                                        // },
                                        onPlay: () {
                                         
                                         widget.assetsAudioPlayer.playOrPause();
                                        },
                                        // onNext: () {
            
                                        //   assetsAudioPlayer.next(
                                        //       keepLoopMode:
                                        //           true );
                                        // },
                                        // onPrevious: () {
                                        //   assetsAudioPlayer.previous(
                                        //     );
                                        // },
                                      );
                                    });
                              },
                            ),
                          ],
                        )
                ),
               
                );
          },
        ),
      ],
    );
  }
}
