import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/pods.dart';
import '../../models/logper.dart';
import 'firestore_base_manager.dart';
import 'partner_firestore_base_manager.dart';

class LogperFirestoreCache
    implements FirestoreManager, PartnerFirestoreManager {
  LogperFirestoreCache(this._read);

  final Reader _read;

  @override
  Future<Logper?> getUser(String userID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _read(firestoreLogperPod).where("uid", isEqualTo: userID).get();
    if (querySnapshot.size == 1) {
      for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Logper logper = Logper.fromMap(documentSnapshot.data()!);
        return logper;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Logper> readUser(String userID) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _read(firestoreLogperPod).doc(userID).get();
    Logper logper = Logper.fromMap(documentSnapshot.data()!);
    return logper;
  }

  @override
  Future<bool> saveUser(Logper logper) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _read(firestoreLogperPod).doc(logper.uid).get();
    if (documentSnapshot.data() == null) {
      logper.fcmToken = await _read(fireMessagePod).getToken();
      print("documentSnapshot giden logper" + logper.toString());
      await _read(firestoreLogperPod).doc(logper.uid).set(logper.toMap());
      return true;
    } else {
      String? newTOken = await _read(fireMessagePod).getToken();
      if (documentSnapshot.data()!["fcmToken"] != newTOken) {
        await _read(firestoreLogperPod)
            .doc(logper.uid)
            .update({"fcmToken": newTOken});
        return true;
      } else {
        return true;
      }
    }
  }

  @override
  Future<bool> updateProfilePhotoURL(String userID, String newPhotoURL) async {
    await _read(firestoreLogperPod)
        .doc(userID)
        .update({"photoURL": newPhotoURL});
    return true;
  }

  @override
  Future<List<Logper>?> getUserList() async {
    List<Logper>? _logperList;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _read(firestoreLogperPod).orderBy("uid").get();
    if (querySnapshot.docs.isEmpty) {
      return null;
    } else {
      _logperList = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        Logper logper = Logper.fromMap(doc.data());
        _logperList.add(logper);
      }
    }
    return _logperList;
  }
}
