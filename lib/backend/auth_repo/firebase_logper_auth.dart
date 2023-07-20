import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../const/pods.dart';
import '../../models/logper.dart';
import 'auth_base_repo.dart';
import 'partner_auth_base.dart';

class FirebaseRepo implements AuthRepo, PartnerAuthBase {
  final Reader _read;
  String? _fcmToken;

  FirebaseRepo(this._read) {
    _read(fireMessagePod).getToken().then((value) => _fcmToken = value);
  }

  Logper _userToLogper(User user, String? fcmToken) {
    return Logper(
        uid: user.uid,
        email: user.email,
        photoURL: user.photoURL,
        fcmToken: fcmToken);
  }

  @override
  Future<Logper?> createLogperWEmailNPass(String email, String password) async {
    UserCredential userCredential = await _read(firebaseAuthPod)
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null && _fcmToken != null) {
      Logper logper = _userToLogper(userCredential.user!, _fcmToken!);
      return logper;
    } else {
      return null;
    }
  }

  @override
  Future<Logper?> getCurrentUser() async {
    User? currentUser = _read(firebaseAuthPod).currentUser;
    var _fcmTokenIn = await _read(fireMessagePod)
        .getToken(); // Future eklemek zorunda kaldık token eklemek için. Doğru değil böyle uygulamak.
    if (currentUser != null && _fcmTokenIn != null) {
      Logper logper = _userToLogper(currentUser, _fcmTokenIn);
      return logper;
    } else {
      return null;
    }
  }

  @override
  Future<Logper?> signInAnonym() async {
    UserCredential userCredential =
        await _read(firebaseAuthPod).signInAnonymously();
    if (userCredential.user != null && _fcmToken != null) {
      Logper logper = _userToLogper(userCredential.user!, _fcmToken!);
      return logper;
    } else {
      return null;
    }
  }

  @override
  Future<Logper?> signInEmailWPass(String email, String password) async {
    UserCredential userCredential = await _read(firebaseAuthPod)
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null && _fcmToken != null) {
      Logper logper = _userToLogper(userCredential.user!, _fcmToken!);

      return logper;
    } else {
      return null;
    }
  }

  @override
  Future<Logper?> signInWGoogle() async {
    GoogleSignInAccount? googleSignInAccount =
        await _read(googleSignPod).signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential userCredential =
          await _read(firebaseAuthPod).signInWithCredential(credential);
      if (userCredential.user != null && _fcmToken != null) {
        Logper logper = _userToLogper(userCredential.user!, _fcmToken!);
        return logper;
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _read(firebaseAuthPod).signOut();
    await _read(googleSignPod).signOut();
  }

  @override
  Future<void> uploadPhoto(String photoUrl) async {
    await _read(firebaseAuthPod).currentUser?.updatePhotoURL(photoUrl);
  }
}
