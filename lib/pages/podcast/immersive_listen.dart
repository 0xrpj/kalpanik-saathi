import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:velocity_x/velocity_x.dart';

class ImmersiveListenPage extends StatefulWidget {
  const ImmersiveListenPage({Key? key}) : super(key: key);

  @override
  _ImmersiveListenPageState createState() => _ImmersiveListenPageState();
}

class _ImmersiveListenPageState extends State<ImmersiveListenPage> {
  late List<dynamic> audios;
  late String _selectedAudio;
  bool _isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

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
    return Scaffold(
      body: Stack(children: [
        VxAnimatedBox()
            .size(context.screenWidth, context.screenHeight)
            .withGradient(const LinearGradient(
                colors: [Colors.greenAccent, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight))
            .make(),
        VxSwiper.builder(
            itemCount: audios.length,
            aspectRatio: 1,
            enlargeCenterPage: true,
            itemBuilder: (context, index) {
              // final rad = audios[index];
              // print(audios[index]);
              return VxBox(child: const ZStack([]))
                  .clip(Clip.antiAlias)
                  .bgImage(DecorationImage(
                      image: NetworkImage(audios[index]['image'] as String),
                      fit: BoxFit.cover))
                  .border(color: Colors.white)
                  .withRounded(value: 60.0)
                  .make()
                  .onInkTap(() {
                _playMusic(audios[index]['url'] as String);
                // });
              }).p16();
            }).centered(),
        Align(
          alignment: Alignment.bottomCenter,
          child: [
            if (_isPlaying) 'Playing Now'.text.white.makeCentered(),
            Icon(
              _isPlaying
                  ? CupertinoIcons.stop_circle
                  : CupertinoIcons.play_circle,
              color: Colors.white,
              size: 50.0,
            ).onInkTap(() {
              if (_isPlaying) {
                _audioPlayer.stop();
              } else {
                _playMusic(_selectedAudio);
                // print(_selectedAudio);
              }
            })
          ].vStack(),
        ).pOnly(bottom: context.percentHeight * 12)
      ], fit: StackFit.expand),
    );
  }
}
