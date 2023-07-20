import '../const/identity.dart';
import '../const/shorten.dart';
import 'package:hive_flutter/adapters.dart';

part 'logper.g.dart';

@HiveType(typeId: Identity.hiveTypeLogper)
class Logper {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? photoURL;

  @HiveField(3)
  String? fcmToken;

  Logper({this.uid, this.email, this.photoURL, this.fcmToken}) {
    photoURL ??= Shorten.noProfilePicUrl;
  }

  Logper.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    email = map["email"];
    photoURL = map["photoURL"];
    fcmToken = map["fcmToken"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "photoURL": photoURL,
      "fcmToken": fcmToken
    };
  }

  @override
  String toString() {
    return 'Logper(uid: $uid, email: $email, photoURL: $photoURL, fcmToken: $fcmToken)';
  }
}
