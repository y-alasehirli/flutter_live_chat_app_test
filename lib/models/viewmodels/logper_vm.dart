import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../backend/hub_center.dart';
import '../../const/pods.dart';
import '../logper.dart';

enum LogperAuthState { authenticated, authenticating, needAuth }

class LogperVM extends StateNotifier<LogperAuthState> implements Hub {
  LogperVM(LogperAuthState state, this._read)
      : super(LogperAuthState.needAuth) {
    // _read(authStateChangePod.stream).listen(_authStateChanged);
    getCurrentUser().then((value) => _logper = value);
    getUserList().then((value) => _logperList = value);
  }

  final Reader _read;
  Logper? _logper;
  List<Logper>? _logperList;

  List<Logper>? get logperList => _logperList;
  Logper? get logper => _logper;

  @override
  Future<Logper?> createLogperWEmailNPass(String email, String password) async {
    state = LogperAuthState.authenticating;
    try {
      Logper? logper =
          await _read(hubPod).createLogperWEmailNPass(email, password);
      if (logper != null) {
        state = LogperAuthState.authenticated;
        _logper = logper;
        return _logper;
      } else {
        state = LogperAuthState.needAuth;
      }
    } finally {}
  }

  @override
  Future<Logper?> getCurrentUser() async {
    state = LogperAuthState.authenticating;
    try {
      Logper? logper = await _read(hubPod).getCurrentUser();
      print("current geldi : $logper ");
      if (logper != null) {
        _logper = logper;
        state = LogperAuthState.authenticated;
        return _logper;
      } else {
        _logper = null;
        state = LogperAuthState.needAuth;
      }
    } on Exception catch (e) {
      print("getCurrentUser hata : $e");
      state = LogperAuthState.needAuth;
      return null;
    } finally {}
  }

  @override
  Future<Logper?> signInAnonym() async {
    state = LogperAuthState.authenticating;
    try {
      Logper? logper = await _read(hubPod).signInAnonym();
      if (logper != null) {
        state = LogperAuthState.authenticated;
        _logper = logper;
        return _logper;
      } else {
        state = LogperAuthState.needAuth;
      }
    } on Exception catch (e) {
      print("signInAnonym hata : $e");
      return null;
    } finally {}
  }

  @override
  Future<Logper?> signInEmailWPass(String email, String password) async {
    state = LogperAuthState.authenticating;
    try {
      Logper? logper = await _read(hubPod).signInEmailWPass(email, password);
      if (logper != null) {
        state = LogperAuthState.authenticated;
        _logper = logper;
        print("VM signinEmail Logper: " + _logper.toString());
        return _logper;
      } else {
        state = LogperAuthState.needAuth;
      }
    } finally {}
  }

  @override
  Future<Logper?> signInWGoogle() async {
    state = LogperAuthState.authenticating;
    try {
      Logper? logper = await _read(hubPod).signInWGoogle();
      if (logper != null) {
        state = LogperAuthState.authenticated;
        _logper = logper;
        return _logper;
      } else {
        state = LogperAuthState.needAuth;
      }
    } on Exception catch (e) {
      print("signInWGoogle hata : $e");
      return null;
    } finally {}
  }

  @override
  Future<void> signOut() async {
    state = LogperAuthState.authenticating;
    try {
      await _read(hubPod).signOut();
      _logper = null;
      _logperList = null;
      state = LogperAuthState.needAuth;
    } on Exception catch (e) {
      state = LogperAuthState.needAuth;
      print("signOut hata : $e");
    } finally {
      state = LogperAuthState.needAuth;
    }
  }

  @override
  Future<String?> uploadPhoto(
      String userID, String folderName, XFile uploadFile) async {
    try {
      String? _check =
          await _read(hubPod).uploadPhoto(userID, folderName, uploadFile);
      if (_check != null) {
      } else {}
    } on Exception catch (e) {
      print("uploadPhoto hata : $e");
      return null;
    } finally {}
  }

  @override
  Future<List<Logper>?> getUserList() async {
    try {
      List<Logper>? _userList = await _read(hubPod).getUserList();
      print("user list geldi : $logper ");
      if (_userList != null) {
        _logperList = _userList;
        return _logperList;
      } else {
        _logperList = null;
      }
    } on Exception catch (e) {
      print("getCurrentUser hata : $e");
      _logperList = null;
    } finally {}
  }
}
