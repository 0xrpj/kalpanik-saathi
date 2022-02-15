import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';

late Map<String, dynamic> post_data;

class PostDetail extends StatefulWidget {
  const PostDetail({required this.postId});

  final String postId;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  var repo = DataRepository();

  @override
  void initState() {
    super.initState();
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
                                post_data['userId'].toString() +
                                '.png',
                            height: 30,
                            // width: 30,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('roshan.parajuli says',
                            style: TextStyle(
                              fontFamily: 'PoppinsLight',
                              fontWeight: FontWeight.w900,
                              fontSize: 14.0,
                              letterSpacing: 0.3,
                              // ),),/
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(post.postContent.toString()),
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
                margin: EdgeInsets.all(8.0),
                elevation: 8,
                shadowColor: Colors.grey.withOpacity(0.15),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text('Comments should load here!!'),
                ))
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
}
