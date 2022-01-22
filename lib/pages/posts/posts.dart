import 'dart:convert';

// import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:kalpaniksaathi/models/posts.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';
import 'package:kalpaniksaathi/services/auth.dart';
import 'package:like_button/like_button.dart';

// class Data {
//   final dynamic userId;
//   final dynamic id;
//   final dynamic title;

//   Data({required this.userId, required this.id, required this.title});

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final DataRepository repository = DataRepository();
  final User _currentUser = AuthService().getUser();

  //text field controller
  TextEditingController _postBodyController = TextEditingController();

  // Future<List<Data>>? futureData;

  @override
  void initState() {
    super.initState();
    // futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        primary: false,
        // physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            color: const Color(0xFFF8F8F8),
            child: Column(
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(18.0),
                      // color: Colors.white60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Share your feelings',
                              style: TextStyle(
                                  fontFamily: 'WorkSansMedium', fontSize: 17),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            TextField(
                              controller: _postBodyController,
                              // style: TextStyle(
                              //   height: 5.0,
                              // ),

                              maxLines: null,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write',
                                  labelStyle: TextStyle(
                                    fontFamily: "WorkSansMedium",
                                    fontSize: 15,
                                  ),
                                  focusColor: Color(0xFF88C03D)

                                  // isDense: true,
                                  // contentPadding: EdgeInsets.all(28),
                                  ),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF88C03D))),
                              onPressed: () {
                                final newPost = Post(
                                  "post1",
                                  userId: _currentUser.uid.toString(),
                                  postContent: _postBodyController.text,
                                );
                                repository.addPost(newPost);
                                print("posted");
                              },
                              child: const Text('Share',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'WorkSansMedium')),
                            ),
                          ]),
                    ),

                    // AnimatedButton()
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Read what others are feeling...',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                StreamBuilder<QuerySnapshot>(
                    stream: repository.getStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return LinearProgressIndicator();

                      return _buildList(context, snapshot.data?.docs ?? []);
                    }),
                // Expanded(
                //   child: FutureBuilder(
                //       future: futureData,
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           List<Data> data = snapshot.data as List<Data>;
                //           print(data);

                //           return ListView.builder(
                //               shrinkWrap: true,
                //               itemCount: data.length,
                //               itemBuilder: (BuildContext context, int index) {
                //                 // return Container(
                //                 //   height: 45,
                //                 //   color: Colors.white,
                //                 //   child: SingleChildScrollView(
                //                 //     child: Center(
                //                 //       child: Text(data[index].title as String),
                //                 //     ),
                //                 //   ),
                //                 // );
                //                 return SingleChildScrollView(
                //                   child: Column(
                //                     children: <Widget>[
                //                       const Padding(
                //                         padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                //                         child: ListTile(
                //                           // title: Text(data[index].title as String),
                //                           title: Text('Lorem'),
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                //                         child: Row(
                //                           mainAxisAlignment: MainAxisAlignment.end,
                //                           children: <Widget>[
                //                             LikeButton(
                //                               size: 30,
                //                               circleColor: const CircleColor(
                //                                   start: Color(0xff90ee90),
                //                                   end: Color(0xff0099cc)),
                //                               bubblesColor: const BubblesColor(
                //                                 dotPrimaryColor: Colors.green,
                //                                 dotSecondaryColor:
                //                                     Color(0xff0099cc),
                //                               ),
                //                               likeBuilder: (bool isLiked) {
                //                                 return Icon(
                //                                   // icon: Feather.heart,
                //                                   Ionicons.heart_outline,
                //                                   color: isLiked
                //                                       ? Colors.red[600]
                //                                       : Colors.black,
                //                                   size: 30,
                //                                 );
                //                               },
                //                             ),

                //                             SizedBox(
                //                               width: 10,
                //                             ),

                //                             Icon(Ionicons.chatbubble_outline),
                //                             // Text('Dislike'),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 );
                //               });
                //         } else if (snapshot.hasError) {
                //           return Text("${snapshot.error}");
                //         } else {
                //           return Text('');
                //         }
                //       }),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// void printHi() {
//   print('Button pressed');
// }

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    child: ListView(
        primary: false,
        children:
            snapshot.map((data) => _buildListItem(context, data)).toList()),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  final post = Post.fromSnapshot(snapshot);

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Card(
          elevation: 8,
          shadowColor: Colors.grey.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                //insert an small image here

                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        "https://cdn.dribbble.com/users/60880/screenshots/1497124/avatar.png",
                        height: 30,
                        // width: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("roshan.parajuli")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(post.postContent.toString()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      LikeButton(
                        size: 30,
                        circleColor: const CircleColor(
                            start: Color(0xff90ee90), end: Color(0xff0099cc)),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            // icon: Feather.heart,
                            isLiked ? Ionicons.heart : Ionicons.heart_outline,
                            color:
                                // isLiked ? Color(0xFF88C03D) : Colors.grey[700],
                                isLiked ? Colors.red : Colors.grey[700],
                            size: 30,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Ionicons.chatbubble_outline),
                    ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Future<List<Data>> fetchData() async {
//   final http.Response response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

//   if (response.statusCode == 200) {
//     final List<dynamic> jsonResponse =
//         json.decode(response.body) as List<dynamic>;
//     return jsonResponse
//         .map((dynamic data) => Data.fromJson(data as Map<String, dynamic>))
//         .toList();
//   } else {
//     throw Exception('Unexpected error occured!');
//   }
// }
