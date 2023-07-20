import 'data_manager/partner_firestore_base_manager.dart';
import 'storage_repo/storage_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../const/pods.dart';
import '../models/logper.dart';
import 'auth_repo/auth_base_repo.dart';

class Hub implements AuthRepo, StorageBase, PartnerFirestoreManager {
  final Reader _read;

  Hub(this._read);

  @override
  Future<Logper?> createLogperWEmailNPass(String email, String password) async {
    Logper? logper =
        await _read(firebaseRepoPods).createLogperWEmailNPass(email, password);
    if (logper != null) {
      bool bResult = await _read(logperFirestorePod).saveUser(logper);
      if (bResult) {
        await _read(logperCachePods).putOItem(logper.uid!, logper);
        return logper;
      }
    }
    return null;
  }

  @override
  Future<Logper?> getCurrentUser() async {
    Logper? logper = await _read(firebaseRepoPods).getCurrentUser();
    if (logper != null) {
      Logper _logper = await _read(logperFirestorePod).readUser(logper.uid!);
      return _logper;
    }
    return null;
  }

  @override
  Future<Logper?> signInAnonym() async {
    Logper? logper = await _read(firebaseRepoPods).signInAnonym();
    if (logper != null) {
      bool bResult = await _read(logperFirestorePod).saveUser(logper);
      if (bResult) {
        await _read(logperCachePods).addOItem(logper);
        return logper;
      }
    }
    return null;
  }

  @override
  Future<Logper?> signInEmailWPass(String email, String password) async {
    Logper? logper =
        await _read(firebaseRepoPods).signInEmailWPass(email, password);
    if (logper != null) {
      bool bResult = await _read(logperFirestorePod).saveUser(logper);
      if (bResult) {
        await _read(logperCachePods).putOItem(logper.uid!, logper);
        var item = _read(logperCachePods).getItem(logper.uid!);
        print("getItem:" + item.toString());
        return logper;
      }
    }
    return null;
  }

  @override
  Future<Logper?> signInWGoogle() async {
    Logper? logper = await _read(firebaseRepoPods).signInWGoogle();
    if (logper != null) {
      bool bResult = await _read(logperFirestorePod).saveUser(logper);
      if (bResult) {
        await _read(logperCachePods).putOItem(logper.uid!, logper);
        return logper;
      }
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _read(firebaseRepoPods).signOut();
    
  }

  @override
  Future<String?> uploadPhoto(
      String userID, String folderName, XFile uploadFile) async {
    String? _photoUrl = await _read(fireStorageRepoPod)
        .uploadPhoto(userID, folderName, uploadFile);
    if (_photoUrl != null) {
      bool bResult = await _read(logperFirestorePod)
          .updateProfilePhotoURL(userID, _photoUrl);
      if (bResult) {
        await _read(firebaseRepoPods).uploadPhoto(_photoUrl);
      }
    } else {
      return null;
    }
  }

  @override
  Future<List<Logper>?> getUserList() async {
    List<Logper>? logperList = await _read(logperFirestorePod).getUserList();
    return logperList;
  }
}
