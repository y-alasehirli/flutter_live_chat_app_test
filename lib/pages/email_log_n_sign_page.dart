import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/pods.dart';
import '../const/shorten.dart';
import '../const/ui_theme.dart';

class EmailLogNSignPage extends StatefulWidget {
  const EmailLogNSignPage({Key? key}) : super(key: key);

  @override
  State<EmailLogNSignPage> createState() => _EmailLogNSignPageState();
}

class _EmailLogNSignPageState extends State<EmailLogNSignPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.09, horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: UITheme.radiusCircular),
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                CircleAvatar(
                    backgroundColor: UITheme.backgroundColor,
                    child: Image.network(Shorten.owlPostPicUrl),
                    maxRadius: 60),
                const Expanded(child: SizedBox()),
                TextFormField(
                  initialValue: "hopdedilaylom@hotmail.com",
                  validator: (text) {
                    if (!EmailValidator.validate(text!, true)) {
                      return "Hatalı email adresi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) {
                    _email = email!;
                  },
                  cursorColor: UITheme.errorColor,
                  decoration: UITheme.textFormFieldDecoration("eposta"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: "sananehopdedimlaylom",
                  obscureText: true,
                  obscuringCharacter: "✘",
                  validator: (text) {
                    if (text!.length < 6) {
                      return "En az 6 karakter giriniz";
                    }
                    return null;
                  },
                  onSaved: (password) {
                    _password = password!;
                  },
                  cursorColor: UITheme.errorColor,
                  decoration: UITheme.textFormFieldDecoration("şifre"),
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return ButtonBar(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  _formKey.currentState!.save();
                                  await ref
                                      .read(logperPods.notifier)
                                      .createLogperWEmailNPass(
                                          _email!, _password!);

                                  Navigator.pop(context);
                                } on Exception catch (e) {
                                  _email = null;
                                  _password = null;
                                  UITheme.alertErrorDialog(context, e);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: UITheme.radiusCircular),
                                primary: UITheme.secondaryColor),
                            child: const Text("Kayıt Ol")),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                _formKey.currentState!.save();
                                await ref
                                    .read(logperPods.notifier)
                                    .signInEmailWPass(_email!, _password!);
                                Navigator.pop(context);
                              } on Exception catch (e) {
                                _email = null;
                                _password = null;
                                UITheme.alertErrorDialog(context, e);
                              }
                            }
                          },
                          child: const Text("Giriş Yap"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: UITheme.radiusCircular),
                          ),
                        )
                      ],
                    );
                  },
                ),
                const Expanded(child: SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
