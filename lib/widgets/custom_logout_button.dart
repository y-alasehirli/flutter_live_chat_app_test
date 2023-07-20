import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/pods.dart';

class CustomLogOutButton extends ConsumerWidget {
  const CustomLogOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () {
          ref.read(logperPods.notifier).signOut();
        },
        icon: const Icon(Icons.logout));
  }
}
