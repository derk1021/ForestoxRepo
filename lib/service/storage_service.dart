import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageService extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadImage(XFile image, String uid) async {
    try {
      Reference reference = storage
          .ref()
          .child("$uid/${DateTime.now().millisecondsSinceEpoch}_${image.name}");

      //Upload the file to firebase
      UploadTask uploadTask = reference.putFile(File(image.path));

      TaskSnapshot taskSnapshot = await uploadTask;

      // Waits till the file is uploaded then stores the download url
      String url = await taskSnapshot.ref.getDownloadURL();
      log("Image URL ==> $url");
      return url;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> uploadFile(File file, String uid) async {
    try {
      var bytes = await file.readAsBytes();
      if (bytes == null) {
        return null;
      }
      Reference reference = storage.ref().child(
          "$uid/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}");

      //Upload the file to firebase
      UploadTask uploadTask = reference.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask;

      // Waits till the file is uploaded then stores the download url
      String url = await taskSnapshot.ref.getDownloadURL();
      log("File URL ==> $url");
      return url;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> deleteUserFiles(String uid) async {
    try {
      var files = await storage.ref(uid).listAll();
      for (var file in files.items) {
        await file.delete();
      }
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
