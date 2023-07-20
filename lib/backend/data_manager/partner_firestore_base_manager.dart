import '../../models/logper.dart';

abstract class PartnerFirestoreManager {
  Future<List<Logper>?> getUserList();
}
