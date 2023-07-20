import '../../models/logper.dart';

abstract class AuthRepo {
  Future<Logper?> createLogperWEmailNPass(String email, String password);
  Future<Logper?> signInAnonym();
  Future<Logper?> signInEmailWPass(String email, String password);
  Future<Logper?> signInWGoogle();
  Future<Logper?> getCurrentUser();
  Future<void> signOut();
}
