import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kalpaniksaathi/models/posts.dart';

// import '../models/pets.dart';

class DataRepository {
  // final CollectionReference collection =
  //     FirebaseFirestore.instance.collection('pets');
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('posts');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPost(Post post) {
    return collection.add(post.toJson());
  }

  void updatePost(Post post) async {
    await collection.doc(post.postId).update(post.toJson());
  }

  // 5
  void deletePost(Post post) async {
    await collection.doc(post.postId).delete();
  }
}
