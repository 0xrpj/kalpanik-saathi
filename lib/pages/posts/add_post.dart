import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/models/posts.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';
import 'package:kalpaniksaathi/services/auth.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final User _currentUser = AuthService().getUser();
  final DataRepository repository = DataRepository();
  final TextEditingController _postBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              height: 500,
              child: Card(
                // give height and width to the card

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
                        children: const [
                          Text('Share with your heart\'s content!',
                              style: TextStyle(
                                fontFamily: 'PoppinsLight',
                                fontWeight: FontWeight.w900,
                                fontSize: 14.0,
                                letterSpacing: 0.3,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // const Text(
                      //   'Share your feelings',
                      //   style: TextStyle(
                      //       fontFamily: 'WorkSansMedium', fontSize: 17),
                      // ),
                      TextField(
                          controller: _postBodyController,
                          style: const TextStyle(
                            height: 1.0,
                          ),
                          maxLines: null),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF00AC97)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ))),
                        onPressed: () {
                          final newPost = Post(const Uuid().v4(),
                              userId: _currentUser.uid.toString(),
                              postContent: _postBodyController.text,
                              createdAt: DateTime.now().millisecondsSinceEpoch);
                          repository.addPost(newPost);
                          Navigator.pop(context);
                        },
                        child: const Text('Share',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'WorkSansMedium')),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
