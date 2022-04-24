import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class ListenPage extends StatefulWidget with WidgetsBindingObserver {
  const ListenPage({Key? key}) : super(key: key);

  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  late List<dynamic> audios;
  late String _selectedAudio;
  bool _isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _audioPlayer.resume();
    } else {
      _audioPlayer.pause();
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();

    fetchAudios();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  void fetchAudios() async {
    final Map<String, dynamic> myData =
        json.decode(await getJson()) as Map<String, dynamic>;

    setState(() {
      audios = myData['audios'] as List<dynamic>;
      _selectedAudio = audios[0]['url'] as String;
    });
  }

  Future<String> getJson() {
    return rootBundle.loadString('assets/audio.json');
  }

  void _playMusic(String url) {
    print('Playing url' + url);
    _audioPlayer.play(url);

    setState(() {
      for (final audio in audios) {
        if (audio['url'] == url) {
          _selectedAudio = url;
          print(_selectedAudio);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('  EEE d MMM').format(now);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 80),
      child: Container(
          child: Stack(children: [
        // VxAnimatedBox()
        //     .size(context.screenWidth, context.screenHeight)
        //     .withGradient(const LinearGradient(
        //         colors: [Colors.greenAccent, Colors.green],
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight))
        //     .make(),

        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Welcome to your space. \n        Get motivated.\n        Get stuff done.',
                style: TextStyle(
                    // color: Colors.yellow[900],
                    fontFamily: 'PoppinsLight',
                    fontSize: 25),
              ),
            ],
          ),
        ),
        VxSwiper.builder(
            itemCount: audios.length,
            aspectRatio: 1,
            enlargeCenterPage: true,
            itemBuilder: (context, index) {
              return VxBox(child: const ZStack([]))
                  .clip(Clip.antiAlias)
                  .bgImage(DecorationImage(
                      image: NetworkImage(audios[index]['image'] as String),
                      fit: BoxFit.cover))
                  .border(color: Colors.white)
                  .withRounded(value: 60.0)
                  .make()
                  .onInkTap(() {
                if (_isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.pause();

                  _playMusic(audios[index]['url'] as String);
                }
                // });
              }).p16();
            }).centered(),
        Align(
          alignment: Alignment.bottomCenter,
          child: [
            Text(
              formattedDate,
              style: const TextStyle(
                  // color: Colors.yellow[900],
                  fontFamily: 'PoppinsMedium',
                  fontSize: 22),
            ),
            const SizedBox(height: 18),
            if (!_isPlaying)
              const Text(
                'Click on the tile to play',
                style: TextStyle(
                    // color: Colors.yellow[900],
                    fontFamily: 'Schoolbell',
                    fontSize: 22),
              ),
            if (_isPlaying)
              const Text(
                'Click on the tile to stop',
                style: TextStyle(
                    // color: Colors.yellow[900],
                    fontFamily: 'Schoolbell',
                    fontSize: 22),
              ),
          ].vStack(),
        ).pOnly(bottom: context.percentHeight * 5)
      ])
          // height: context.screenHeight,
          // width: context.screenWidth,
          // child: Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: TextButton(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //             MaterialPageRoute<void>(builder: (BuildContext context) {
          //           return ImmersiveListenPage();
          //         }));
          //       },
          //       child: Text("Navigate to immersive listen")),
          // ),
          ),
    );
  }
}
