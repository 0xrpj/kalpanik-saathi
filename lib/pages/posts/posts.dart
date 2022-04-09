import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kalpaniksaathi/models/posts.dart';
import 'package:kalpaniksaathi/pages/posts/add_post.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';
import 'package:kalpaniksaathi/services/auth.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

import 'post_detail.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final DataRepository repository = DataRepository();
  final User _currentUser = AuthService().getUser();
  List<Post> _postData = [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    getPosts();
    // });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // getPosts();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: context.screenHeight),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 45.0,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF00AC97)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => const AddPost()),
                      ).then((_) async {
                        _postData = [];
                        await getPosts();
                        print('postData');
                        print(_postData.length);
                      });
                    },
                    child: const Text(
                      'Have anything to share? ',
                      style: TextStyle(
                        fontFamily: 'PoppinsLight',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        letterSpacing: 0.3,
                      ),
                    )),
              ),
              SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     // crossAxisAlignment: CrossAxisAlignment.start,
              //     children: const [
              //       Text(
              //         'Read what others are feeling...',
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     ],
              //   ),
              // ),

              // FutureBuilder<void>(
              //     future: getPosts(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(child: Text('Please wait its loading...'));
              //       } else {
              //         if (snapshot.hasError)
              //           return Center(child: Text('Error: ${snapshot.error}'));
              //         else
              //           return Center(
              //               child: Text(
              //                   '${snapshot.data}')); // snapshot.data  :- get your object which is pass from your downloadData() function
              //       }
              //     }),

              // FutureBuilder<void>(
              //     future: getPosts(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       return
              ListView.builder(
                shrinkWrap: true,
                // key: UniqueKey(),
                physics: NeverScrollableScrollPhysics(),
                itemCount: _postData.length,
                itemBuilder: (context, index) {
                  return Card(
                    // key: UniqueKey(),

                    // color: const Color(0xFF00AC97),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.all(8.0),
                    elevation: 8,
                    shadowColor: Colors.grey.withOpacity(0.15),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  'https://avatars.dicebear.com/api/micah/' +
                                      _postData[index].userId.toString() +
                                      '.png',
                                  height: 30,
                                  // width: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Somebody says',
                                  style: TextStyle(
                                    fontFamily: 'PoppinsLight',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3,
                                    // ),),/
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Text(post.postContent.toString()),
                          Text(_postData[index].postContent.toString(),
                              style: const TextStyle(
                                fontFamily: 'WorkSansLight',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                                height: 1.75,
                                // letterSpacing: 0.3,
                                // ),),/
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                if (_currentUser.uid ==
                                    _postData[index].userId) ...[
                                  GestureDetector(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.WARNING,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'Are you sure?',
                                          desc:
                                              'You are about to delete this post.',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () async {
                                            repository
                                                .deletePost(_postData[index]);
                                            _postData = [];
                                            await getPosts();
                                            print('postData');
                                          },
                                        ).show();
                                      },
                                      child: const Icon(AntDesign.delete,
                                          color: Colors.red)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                PostDetail(
                                                    postId: _postData[index]
                                                        .postId as String)),
                                      );
                                    },
                                    child: const Icon(
                                        Ionicons.chatbubble_outline)),
                              ]),
                        ],
                      ),
                    ),
                  );
                },
              )
              // })
            ],
          ),
        ),
      ),
    );
  }

  Future getPosts() async {
    final QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();

    // _postData.clear();

    data.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Post postdata = Post.fromSnapshot(doc);
      setState(() {
        _postData.add(postdata);
      });
    });

    return _postData;
  }
}
