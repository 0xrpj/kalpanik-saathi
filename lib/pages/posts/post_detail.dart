import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/models/comments.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';
import 'package:kalpaniksaathi/services/auth.dart';

late Map<String, dynamic> post_data;

class PostDetail extends StatefulWidget {
  const PostDetail({required this.postId});

  final String postId;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  var repo = DataRepository();
  final User _currentUser = AuthService().getUser();
  final DataRepository repository = DataRepository();
  final TextEditingController _commentController = TextEditingController();

  final List<Comment> _commentData = [];

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: PreferredSize(
          // preferredSize: Size.fromHeight(60), child: AppBarWidget())
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.all(8.0),
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
                                post_data['userId'].toString() +
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
                    Text(post_data['postContent'].toString(),
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
                        children: const <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                        ]),
                  ],
                ),
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 18,
                shadowColor: Colors.grey.withOpacity(0.15),
                child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _commentController,
                                style: const TextStyle(
                                  height: 2.0,
                                ),
                                maxLines: null,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Write something',
                                    labelStyle: TextStyle(
                                      fontFamily: 'WorkSansMedium',
                                      fontSize: 15,
                                    ),
                                    focusColor: Color(0xFF88C03D)

                                    // isDense: true,
                                    // contentPadding: EdgeInsets.all(28),
                                    ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  final Comment newComment = Comment(
                                      postId: widget.postId,
                                      userId: _currentUser.uid.toString(),
                                      commentContent: _commentController.text,
                                      createdAt: DateTime.now()
                                          .millisecondsSinceEpoch);
                                  repository.addComment(newComment);

                                  setState(() {
                                    _commentData.insert(0, newComment);
                                  });

                                  _commentController.clear();
                                },
                                child: const Text('Comment'))
                          ],
                        )))),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 18,
                shadowColor: Colors.grey.withOpacity(0.15),
                child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        // elevation: 8,
                        shadowColor: Colors.grey.withOpacity(0),
                        // child: Text('Hello')
                        child: const Text(
                          'Comments',
                        ),
                      ),
                    ))),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _commentData.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return ;
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        elevation: 8,
                        shadowColor: Colors.grey.withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                              // text align left
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_commentData[index].commentContent
                                    as String)
                              ]),
                        ));

                    // List view for comments
                  }),
            )
          ],
        )),
      )),
    );
  }

  Future getData() async {
    final DocumentSnapshot<Object?> postData =
        await repo.getPostDetail(widget.postId);

    final Map<String, dynamic> data = postData.data()! as Map<String, dynamic>;

    setState(() {
      post_data = data;
    });
  }

  Future getComments() async {
    final QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('comments')
        .where('postId', isEqualTo: widget.postId)
        .orderBy('createdAt', descending: true)
        .get();

    data.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Comment commentData = Comment.fromSnapshot(doc);
      setState(() {
        _commentData.add(commentData);
        print(commentData);
      });
    });
  }
}
