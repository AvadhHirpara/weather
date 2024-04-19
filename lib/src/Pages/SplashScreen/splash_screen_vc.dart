import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/src/Pages/HomeScreen/home_screen.dart';
import 'package:weather/src/Utils/Helper/page_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
       push(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
     ScreenUtil.init(context);
    return const Scaffold();
  }
}
