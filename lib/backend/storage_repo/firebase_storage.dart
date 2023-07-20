import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/pods.dart';
import 'storage_base.dart';

class FireStorageRepo implements StorageBase {
  final Reader _read;

  FireStorageRepo(this._read);

  @override
  Future<String?> uploadPhoto(
      String userID, String folderName, XFile uploadFile) async {
    Reference _storageRef = _read(fireStoragePod)
        .ref()
        .child(userID)
        .child(folderName)
        .child(uploadFile.name);

    UploadTask uploadTask = _storageRef.putFile(File(uploadFile.path));

    String _url = await (await uploadTask).ref.getDownloadURL();
    return _url;
  }
}
