import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const/pods.dart';
import '../models/viewmodels/logper_vm.dart';
import 'home_page.dart';
import 'login_page.dart';
import '../widgets/custom_loading_indi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<User?> _auth = ref.watch(authStateChangePod);

    return _auth.when(
        data: (User? _user) {
          LogperVM _logperVM = ref.watch(logperPods.notifier);
          if (_user == null) {
            return const LoginPage();
          } else {
            print("landingten geçen :" + _logperVM.logper.toString());
            return HomePage(_logperVM.logper, _logperVM.logperList);
          }
        },
        error: (error, stackTrace) => const Text(" Ups. Something goes wrong"),
        loading: () => const CustomLoadingIndi());
    /* switch (logperVMState) {
      case LogperAuthState.needAuth:
        return const LoginPage();
      case LogperAuthState.authenticating:
        return const Material(
            child: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ));
      case LogperAuthState.authenticated:
        return HomePage(logper: logperVM.logper);
      /* case LogperAuthState.idle:
        if (logperVM.logper == null) {
          return const LoginPage();
        } else {
          return HomePage(logper: logperVM.logper);
        } */
    } */
  }
}
