import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/pages/chatbot/chatbot.dart';
import 'package:kalpaniksaathi/pages/posts/posts.dart';
import 'package:kalpaniksaathi/pages/widgets/appbar.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  int _currentIndex = 0;
  final tabs = [ChatPage(), Posts(), PostDetail()];
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: AppBarWidget()));
  }
}
