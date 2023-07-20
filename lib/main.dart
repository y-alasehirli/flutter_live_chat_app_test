import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'const/ui_theme.dart';
import 'pages/landing_page_with_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

Future<void> initHiveDriver() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  print("dir/path:" + appDocumentDirectory.path);
  await Hive.initFlutter(appDocumentDirectory.path);
  //await LogperHiveCache(Identity.firestoreLogperKey).init();
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(UITheme.statusBarTheme);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHiveDriver();
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: UITheme.mainThemeData,
      title: '10Line Messaging',
      home: const LandingPageVM(),
    );
  }
}
