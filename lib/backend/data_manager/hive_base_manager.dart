import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveManager<T> {
  final String key;
  Box<T>? _box;
  HiveManager(this.key);

  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox<T>(key);
      var isOpen = _box?.isOpen;
      print("box açıldı mı :" +
          isOpen.toString() +
          "açılanBox" +
          _box!.name.toString());
      print("openedBox values : ${_box?.values.toList()}");
    }
  }

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> addOItem(T item);
  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);
  Future<void> putOItem(String key, T item);
  T? getItem(String key);
  List<T>? getValues();
  Future<void> removeItem(String key);
  void registerAdapters();
}
