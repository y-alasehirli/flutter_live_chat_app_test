import 'package:image_picker/image_picker.dart';

abstract class StorageBase {
  Future<String?> uploadPhoto(
      String userID, String folderName, XFile uploadFile);
}
