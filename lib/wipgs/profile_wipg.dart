import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../const/identity.dart';
import '../const/pods.dart';
import '../const/ui_theme.dart';
import '../models/logper.dart';

class ProfileWipg extends StatefulWidget {
  const ProfileWipg(this._logper, {Key? key}) : super(key: key);
  final Logper? _logper;

  @override
  State<ProfileWipg> createState() => _ProfileWipgState();
}

class _ProfileWipgState extends State<ProfileWipg> {
  XFile? _newPhotoPath;

  _profilePicCheck() {
    return _newPhotoPath == null
        ? NetworkImage(widget._logper!.photoURL!)
        : FileImage(File(_newPhotoPath!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 8,
                  shape: UITheme.cardShape
                      .copyWith(borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: MediaQuery.of(context).size.height * 0.12,
                    backgroundImage: _profilePicCheck(),
                  ),
                ),
              ),
              Positioned(
                  right: MediaQuery.of(context).size.width * 0.2,
                  bottom: 5,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      final ImagePicker _picker = ImagePicker();
                      UITheme.alertButtonNoTitleDialog(context, [
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                            return IconButton(
                                onPressed: () async {
                                  XFile? xFile = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (xFile != null) {
                                    setState(() {
                                      _newPhotoPath = xFile;
                                      Navigator.pop(context);
                                    });
                                    await ref
                                        .read(logperPods.notifier)
                                        .uploadPhoto(
                                            widget._logper!.uid!,
                                            Identity.profileWipgFolderName,
                                            xFile);
                                  }
                                },
                                icon: const Icon(CupertinoIcons.photo));
                          },
                        ),
                        Consumer(builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return IconButton(
                              onPressed: () async {
                                XFile? xFile = await _picker.pickImage(
                                    source: ImageSource.camera);
                                if (xFile != null) {
                                  setState(() {
                                    _newPhotoPath = xFile;
                                    Navigator.pop(context);
                                  });
                                  await ref
                                      .read(logperPods.notifier)
                                      .uploadPhoto(
                                          widget._logper!.uid!,
                                          Identity.profileWipgFolderName,
                                          xFile);
                                }
                              },
                              icon: const Icon(CupertinoIcons.camera));
                        }),
                      ]);
                    },
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      size: 25,
                    ),
                  ))
            ]),
            const Divider(),
            TextField(
              enabled: true,
              readOnly: true,
              decoration: UITheme.textFormFieldDecoration("email").copyWith(
                  hintText: widget._logper!.email,
                  suffixIcon: const Icon(Icons.lock_open_outlined)),
            )
          ],
        ),
      ),
    );
  }
}
