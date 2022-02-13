import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalpaniksaathi/models/audio.dart';
import 'package:velocity_x/velocity_x.dart';

class ImmersiveListenPage extends StatefulWidget {
  const ImmersiveListenPage({Key? key}) : super(key: key);

  @override
  _ImmersiveListenPageState createState() => _ImmersiveListenPageState();
}

class _ImmersiveListenPageState extends State<ImmersiveListenPage> {
  late List<MyAudio> audios;

  @override
  void initState() {
    super.initState();

    // fetchAudios();
    printHello();
  }

  // void fetchAudios() async {
  //   final audioJson = await rootBundle.loadString('assets/audio.json');
  //   print("Fetching audios");
  //   audios = MyAudioList.fromJson(audioJson).audios;
  //   print(audios);
  // }

  void printHello() {
    print("Hello");
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
            .make()
      ]),
    );
  }
}
