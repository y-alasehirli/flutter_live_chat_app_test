import 'package:hive_flutter/hive_flutter.dart';

import '../../const/identity.dart';
import '../../models/logper.dart';
import 'hive_base_manager.dart';

class LogperHiveCache extends HiveManager<Logper> {
  LogperHiveCache(String key) : super(key) {
    init();
  }

  Box<Logper>? _box;

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(Identity.hiveTypeLogper)) {
      Hive.registerAdapter(LogperAdapter());
      print("adapter Registered");
    }
  }

  @override
  Future<void> addItems(List<Logper> items) async {
    await _box?.addAll(items);
  }

  @override
  Logper? getItem(String key) {
    var logper = _box?.get(key);
    print("hiveCachegetItem :" + logper.toString());
    return logper;
  }

  @override
  Future<void> putItems(List<Logper> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.uid, e))));
  }

  @override
  Future<void> putOItem(String key, Logper item) async {
    await _box?.put(key, item);
    print("box put0 key: $key , item : $item");
    print("putOıtem values : ${_box?.values.toList()}");
  }

  @override
  Future<void> removeItem(String key) async {
    await _box?.delete(key);
  }

  @override
  List<Logper>? getValues() {
    return _box?.values.toList();
  }

  @override
  Future<void> addOItem(Logper item) async {
    await _box?.add(item);
    print("addOItem : $item");
    print("addOItem values : ${_box?.values.toList()}");
  }
}
