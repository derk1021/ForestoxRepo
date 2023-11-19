import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tonyyaooo/screens/auth/model/user_model.dart';

class FirestoreService {
  static CollectionReference get postsCollection {
    return FirebaseFirestore.instance.collection("posts");
  }

  static CollectionReference get usersCollection {
    return FirebaseFirestore.instance.collection("users");
  }

  static CollectionReference postCommentsCollection(String? postId) {
    return postsCollection.doc(postId).collection('comments');
  }

  static setUser(User user) async {
    await UserModel(
            createdAt: Timestamp.now(),
            userName: user.displayName,
            email: user.email,
            id: user.uid,
            imageUrl: user.photoURL)
        .set();
  }

  static getDiscussions() async {
    var db = FirebaseFirestore.instance;
    await db.collection("posts").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          var image = null;
          if (docSnapshot.get("imageURL") != null) {
            image = docSnapshot.get("imageURL");
          }
          // discussionModelList.add(DiscussionModel(
          //     documentID: docSnapshot.id,
          //     discussionPostedByImage:
          //         Assets.notificationImagesNitificationImageOne,
          //     discussionPostedByName: docSnapshot.get("sender"),
          //     postedTimeAgo: docSnapshot.get("time"),
          //     postDescription: docSnapshot.get("body"),
          //     postImage: image,
          //     noOfLikes: docSnapshot.get("likeNumber"),
          //     noOfComments: docSnapshot.get("commentNumber"),
          //     numbersOfShares: docSnapshot.get("shareNumber")));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
