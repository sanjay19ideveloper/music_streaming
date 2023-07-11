import 'dart:async';

import 'package:file_picker/file_picker.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:music/song_selector.dart';



import 'package:path/path.dart' as path;

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  //final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  late AssetsAudioPlayer assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  String searchText = '';
  String searchQuery = '';

  final audios = <Audio>[
    Audio.network(
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'assets/music/crystal_bloom.mp3',
      //playSpeed: 2.0,
      metas: Metas(
        id: 'Rock',
        title: 'Rock',
        artist: 'Florent Champigny',
        album: 'RockAlbum',
        image: MetasImage.network(
            'https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
      ),
    ),
    // Audio(
    //   'assets/audios/2 country.mp3',
    //   metas: Metas(
    //     id: 'Country',
    //     title: 'Country',
    //     artist: 'Florent Champigny',
    //     album: 'CountryAlbum',
    //     image: MetasImage.asset('assets/images/country.jpg'),
    //   ),
    // ),
    Audio(
      'assets/music/exits__felix.mp3',
      metas: Metas(
        id: 'Electronics',
        title: 'Electronic',
        artist: 'Florent Champigny',
        album: 'ElectronicAlbum',
        image: MetasImage.network(
            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
      ),
    ),
    Audio(
      'assets/audios/hiphop.mp3',
      metas: Metas(
        id: 'Hiphop',
        title: 'HipHop',
        artist: 'Florent Champigny',
        album: 'HipHopAlbum',
        image: MetasImage.network(
            'https://beyoudancestudio.ch/wp-content/uploads/2019/01/apprendre-danser.hiphop-1.jpg'),
      ),
    ),
    Audio(
      'assets/audios/pop.mp3',
      metas: Metas(
        id: 'Pop',
        title: 'Pop',
        artist: 'Florent Champigny',
        album: 'PopAlbum',
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'assets/audios/instrumental.mp3',
      metas: Metas(
        id: 'Instrumental',
        title: 'Instrumental',
        artist: 'Florent Champigny',
        album: 'InstrumentalAlbum',
        image: MetasImage.network(
            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    //_subscriptions.add(assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  // void openPlayer() async {
  //   await assetsAudioPlayer.open(
  //     Playlist(audios: audios, startIndex: 0),
  //     showNotification: true,
  //     autoStart: true,
  //   );
  // }
  void openPlayer() async {
    assetsAudioPlayer =
        AssetsAudioPlayer.newPlayer(); // Create a new player instance
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    await assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor:Color(0xff20262E),
        // backgroundColor: NeumorphicTheme.baseColor(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              fillColor: Color(0xff20262E),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Search',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(15),
                                child: Image.asset('assets/images/search.png',
                                    color: Colors.white),
                                width: 18,
                              )),
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          }),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['mp3'],
                                );
                                print(
                                    'Selected path: ${result!.files.first.path}');
                                final String inputFile =
                                    'result!.files.first.path';
                                final String outputFile =
                                    '/data/user/0/com.singulariswow/cache/file_picker/test.mp3';
                                final int startTimeInSeconds =
                                    10; // Start time in seconds
                                final int durationInSeconds =
                                    20; // Duration in seconds

                                // final FlutterFFmpeg _flutterFFmpeg =
                                //     FlutterFFmpeg();

                              //   final String startTime =
                              //       Duration(seconds: startTimeInSeconds)
                              //           .toString();
                              //   final String duration =
                              //       Duration(seconds: durationInSeconds)
                              //           .toString();
                              //   print('Audio cut started');
                              //  try{
                              //   //  final int rc = await _flutterFFmpeg.execute(
                              //   //     '-i $inputFile -ss $startTime -t $duration -c copy $outputFile');
                              //   print('Audio cut ended');
                              //   if (rc == 0) {
                              //     print('Audio cut successfully');
                              //   } else {
                              //     print('Audio cut failed with rc=$rc');
                              //   }
                              //  }
                              //  catch(e){
                              //   print('Audio cut except : $e');

                              //  }
                            },
                              icon: Icon(Icons.file_upload),
                              label: Text('Storage')),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),

                    // SizedBox(
                    //   height: 20,
                    // ),

                    //   Container(
                    //     height: 60,
                    //     child: Row(children: [
                    //     //   assetsAudioPlayer.builderCurrent(
                    //     //       builder: (context, Playing? playing) {
                    //     //     // return Column(
                    //     //     //   children: <Widget>[
                    //     //     //     assetsAudioPlayer.builderLoopMode(
                    //     //     //       builder: (context, loopMode) {
                    //     //     //         return PlayerBuilder.isPlaying(
                    //     //     //             player: assetsAudioPlayer,
                    //     //     //             builder: (context, isPlaying) {
                    //     //     //               return PlayingControls(
                    //     //     //                 // loopMode: loopMode,
                    //     //     //                 isPlaying: isPlaying,
                    //     //     //                 isPlaylist: true,
                    //     //     //                 // onStop: () {
                    //     //     //                 //   assetsAudioPlayer.stop();
                    //     //     //                 // },
                    //     //     //                 // toggleLoop: () {
                    //     //     //                 //   assetsAudioPlayer.toggleLoop();
                    //     //     //                 // },
                    //     //     //                 onPlay: () {
                    //     //     //                   assetsAudioPlayer.playOrPause();
                    //     //     //                 },
                    //     //     //                 // onNext: () {

                    //     //     //                 //   assetsAudioPlayer.next(
                    //     //     //                 //       keepLoopMode:
                    //     //     //                 //           true );
                    //     //     //                 // },
                    //     //     //                 // onPrevious: () {
                    //     //     //                 //   assetsAudioPlayer.previous(
                    //     //     //                 //     );
                    //     //     //                 // },
                    //     //     //               );
                    //     //     //             });
                    //     //     //       },
                    //     //     //     ),
                    //     //     //   ],
                    //     //     // );
                    //     //   }),
                    //  ]),
                    //   ),

                    // SizedBox(
                    //   height: 20,
                    // ),
                    assetsAudioPlayer.builderCurrent(
                        builder: (BuildContext context, Playing? playing) {
                      return SongsSelector(
                        searchQuery: searchText,
                        audios: audios,
                        onPlaylistSelected: (myAudios) {
                          assetsAudioPlayer.open(
                            Playlist(audios: myAudios),
                            showNotification: true,
                            headPhoneStrategy:
                                HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true),
                          );
                        },
                        onSelected: (myAudio) async {
                          try {
                            await assetsAudioPlayer.open(
                              myAudio,
                              autoStart: true,
                              showNotification: true,
                              playInBackground: PlayInBackground.enabled,
                              audioFocusStrategy: AudioFocusStrategy.request(
                                  resumeAfterInterruption: true,
                                  resumeOthersPlayersAfterDone: true),
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
                              notificationSettings: NotificationSettings(),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                        playing: playing,
                        assetsAudioPlayer: assetsAudioPlayer,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
