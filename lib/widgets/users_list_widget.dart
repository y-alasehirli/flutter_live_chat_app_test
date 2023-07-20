import 'package:flutter/material.dart';
import '../const/ui_theme.dart';
import '../models/logper.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget(this._userList, this._logper, {Key? key})
      : super(key: key);
  final List<Logper> _userList;
  final Logper _logper;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        if (_userList[index].uid == _logper.uid) {
          return const SizedBox();
        }
        return Card(
          elevation: 2,
          shape: UITheme.cardShape,
          child: ListTile(
            leading: Material(
              shape: UITheme.cardShape
                  .copyWith(borderRadius: BorderRadius.circular(30)),
              elevation: 4,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(_userList[index].photoURL!),
              ),
            ),
            title: Text(_userList[index].email.toString()),
          ),
        );
      },
    );
  }
}
