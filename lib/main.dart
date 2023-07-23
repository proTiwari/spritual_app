import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/utils/authentication.dart';
import 'package:explore/utils/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'admin/admin_login.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('box');

  // iniliaze the firebase app
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAGHFbYSrS_oVYEbEyeZpc3KZB5DVM98SU",
        authDomain: "jsow-web.firebaseapp.com",
        projectId: "jsow-web",
        storageBucket: "jsow-web.appspot.com",
        messagingSenderId: "556158876859",
        appId: "1:556158876859:web:e3abb972d166acd5d1fd9e",
        measurementId: "G-FH984SX335"),
  );

  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    //await getUser();
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      routes: {
        '/admin': (context) => AdminLogin(),
      },
      home: HomePage(),
    );
  }
}
