import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/pods.dart';
import '../models/viewmodels/logper_vm.dart';
import '../widgets/custom_loading_indi.dart';
import 'home_page.dart';
import 'login_page.dart';

class LandingPageVM extends ConsumerWidget {
  const LandingPageVM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LogperAuthState _logperAuthState = ref.watch(logperPods);
    LogperVM _logperVM = ref.watch(logperPods.notifier);
    switch (_logperAuthState) {
      case LogperAuthState.needAuth:
        return const LoginPage();

      case LogperAuthState.authenticated:
        return HomePage(_logperVM.logper, _logperVM.logperList);

      case LogperAuthState.authenticating:
        return const CustomLoadingIndi();
    }
  }
}
