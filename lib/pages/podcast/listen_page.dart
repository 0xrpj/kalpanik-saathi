import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'immersive_listen.dart';

class ListenPage extends StatefulWidget {
  const ListenPage({Key? key}) : super(key: key);

  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return ImmersiveListenPage();
              }));
            },
            child: Text("Navigate to immersive listen")),
      ),
    );
  }
}
