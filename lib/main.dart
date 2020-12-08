import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Auth/Login.dart';
import 'Screens/Dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
