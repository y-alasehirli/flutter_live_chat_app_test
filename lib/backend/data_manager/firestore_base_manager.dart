import '../../models/logper.dart';

abstract class FirestoreManager {
  Future<bool> saveUser(Logper logper);
  Future<Logper> readUser(String userID);
  Future<bool> updateProfilePhotoURL(String userID, String newPhotoURL);
  Future<Logper?> getUser(String userID);
  // Future<void> saveFcmToken(String token);
}
