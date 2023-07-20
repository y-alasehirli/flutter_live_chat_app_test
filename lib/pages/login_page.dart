import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/pods.dart';
import '../const/shorten.dart';
import '../const/ui_theme.dart';
import '../widgets/custom_button.dart';
import 'email_log_n_sign_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "10Line Messaging",
                style: UITheme.headtitleMainStyle,
              ),
              CustomImageButton(
                title: "Google ile giriş yap",
                onPressed: () {
                  ref.read(logperPods.notifier).signInWGoogle();
                },
                child: Image.network(Shorten.googleImgUrl),
              ),
              CustomImageButton(
                  title: "Eposta ile giriş yap",
                  child: const Icon(
                    Icons.mail,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                        barrierColor: UITheme.backgroundColor.withOpacity(0.5),
                        context: context,
                        builder: (context) => const EmailLogNSignPage());
                  }),
              CustomImageButton(
                  title: "Misafir ile giriş yap",
                  child: const Icon(
                    Icons.person,
                    size: 35,
                  ),
                  onPressed: () {
                    ref.read(logperPods.notifier).signInAnonym();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
