import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kalpaniksaathi/models/posts.dart';
import 'package:kalpaniksaathi/models/messages.dart';

class DataRepository {
  final CollectionReference posts_collection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference messages_collection =
      FirebaseFirestore.instance.collection('messages');

  Stream<QuerySnapshot> getStream() {
    return posts_collection.snapshots();
  }

  Future<QuerySnapshot> getMessages(String id) {
    return messages_collection
        .where('id', isEqualTo: id)
        .orderBy('createdAt', descending: false)
        .get();
  }

  Future<DocumentReference> addPost(Post post) {
    return posts_collection.add(post.toJson());
  }

  Future<DocumentReference> addMessage(Messages message) {
    return messages_collection.add(message.toJson());
  }

  void updatePost(Post post) async {
    await posts_collection.doc(post.postId).update(post.toJson());
  }

  void deletePost(Post post) async {
    await posts_collection.doc(post.postId).delete();
  }
}
