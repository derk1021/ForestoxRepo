import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tonyyaooo/service/firestore_service.dart';

import '../../../../utils/constants/constant_lists.dart';

class UserModel {
  String? id;
  // String? userId;
  String? userName;
  String? email;
  String? imageUrl;
  // List<String>? likedBy;
  // List<String>? collectedBy;
  // List<String>? sharedBy;
  Timestamp? createdAt;
  UserModel({
    this.id,
    this.email,
    this.imageUrl,
    this.userName,
    // this.sharedBy,
    // this.userId,
    // this.likedBy,
    // this.collectedBy,
    this.createdAt,
  });
  UserModel.fromJson(Object? json) {
    json as Map<String, dynamic>?;
    id = json?['id'];
    // userId = json?['userId'];
    userName = json?['userName'];
    imageUrl = json?['imageUrl'];
    email = json?['email'];
    createdAt = json?['createdAt'];
    // likedBy = json?['likedBy']?.cast<String>();
    // collectedBy = json?['collectedBy']?.cast<String>();
    // sharedBy = json?['sharedBy']?.cast<String>();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['userId'] = userId;
    data['userName'] = userName;
    data['imageUrl'] = imageUrl;
    data['email'] = email;
    data['createdAt'] = createdAt;
    // data['collectedBy'] = collectedBy;
    // data['likedBy'] = likedBy;
    // data['sharedBy'] = sharedBy;
    return data;
  }
}

extension MutateUser on UserModel {
  Future<bool> set() async {
    try {
      await FirestoreService.usersCollection.doc(id).set(toJson());

      return true;
    } catch (e) {
      print((e));
    }
    return false;
  }
}
