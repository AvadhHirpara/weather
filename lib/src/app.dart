import 'package:flutter/material.dart';
import 'package:weather/src/Pages/SplashScreen/splash_screen_vc.dart';
import 'package:weather/src/Repository/shared.dart';

SharedPref sharedPref = SharedPref();

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
