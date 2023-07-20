import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../wipgs/users_wipg.dart';
import '../const/identity.dart';
import '../const/ui_theme.dart';
import '../models/logper.dart';
import '../widgets/custom_logout_button.dart';
import '../wipgs/profile_wipg.dart';

enum _SwitchTabName { users, conversations, profile }

class HomePage extends StatefulWidget {
  const HomePage(this._logper, this._logperList, {Key? key}) : super(key: key);
  final Logper? _logper;
  final List<Logper>? _logperList;

  @override
  _HomePageState createState() => _HomePageState();
}
//TODO: async bozukluğu var _logperList doldurulmasında. FutureBuilder ile önlenir rahatlıkla yada logperVM içerisinde async constructor da getUserList içerisinin doldurulması currentUser içerisinde de doldurulabilir. initState içerisinde de _logperList doldurulabilir ConsumerStatefulWidget ile.

class _HomePageState extends State<HomePage> {
  _SwitchTabName _switchTabName = _SwitchTabName.conversations;

  Widget _tabChanger() {
    switch (_switchTabName) {
      case _SwitchTabName.users:
        return UsersWipg(widget._logper!, widget._logperList);
      case _SwitchTabName.conversations:
        return const Text("Conversation") /* ConversationWipg() */;
      case _SwitchTabName.profile:
        return ProfileWipg(widget._logper);
    }
  }

  void _tabIndexChanged(int i) {
    setState(() {
      _switchTabName = _SwitchTabName.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: UITheme.statusBarTheme,
        title: const Text(
          Identity.appTitle,
          style: UITheme.headtitleMainStyle,
        ),
        actions: const [CustomLogOutButton()],
      ),
      body: _tabChanger(),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        //paddingR: EdgeInsets.symmetric(horizontal: 60),
        borderRadius: 15,
        onTap: _tabIndexChanged,
        currentIndex: _SwitchTabName.values.indexOf(_switchTabName),
        items: UITheme.bottomNavigationItems,
      ),
    );
  }
}
