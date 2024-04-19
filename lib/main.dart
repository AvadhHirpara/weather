import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(Builder(builder: (context) {

    return const MyApp();
  }));
}
