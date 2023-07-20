import 'package:flutter/material.dart';
import 'package:flutter_live_chat_app/models/logper.dart';
import '../widgets/users_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersWipg extends ConsumerWidget {
  const UsersWipg(this._logper, this._logperList, {Key? key}) : super(key: key);
  final Logper _logper;
  final List<Logper>? _logperList;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_logperList != null) {
      return UserListWidget(_logperList!, _logper);
    } else {
      return const Center(
        child: Text("Yazabileceğiniz kullanıcı bulunmamaktadır"),
      );
    }
  }
}
