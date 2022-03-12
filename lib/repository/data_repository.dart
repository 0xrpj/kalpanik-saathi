import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kalpaniksaathi/models/comments.dart';
import 'package:kalpaniksaathi/models/messages.dart';
import 'package:kalpaniksaathi/models/posts.dart';

class DataRepository {
  final CollectionReference posts_collection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference messages_collection =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference comments_collection =
      FirebaseFirestore.instance.collection('comments');

  Stream<QuerySnapshot> getStream() {
    return posts_collection.snapshots();
  }

  Future<QuerySnapshot> getMessages(String id) {
    return messages_collection
        .where('id', isEqualTo: id)
        .orderBy('createdAt', descending: false)
        .get();
  }

  Future<DocumentSnapshot> getPostDetail(String docId) {
    return posts_collection.doc(docId).get();
  }

  Future<DocumentReference> addPost(Post post) {
    return posts_collection.add(post.toJson());
  }

  Future<DocumentReference> addMessage(Messages message) {
    return messages_collection.add(message.toJson());
  }

  Future<DocumentReference> addComment(Comment comment) {
    return comments_collection.add(comment.toJson());
  }

  void updatePost(Post post) async {
    await posts_collection.doc(post.postId).update(post.toJson());
  }

  void deletePost(Post post) async {
    await posts_collection.doc(post.postId).delete();
  }
}
