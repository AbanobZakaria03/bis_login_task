import 'package:flutter/material.dart';
import 'package:loginfit/pages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants.dart';
import 'pages/login_screen.dart';

late final SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: grey,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: checkLogin() ? const HomeScreen() : const LoginScreen(),
    );
  }

  bool checkLogin() {
    final bool isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }
}
