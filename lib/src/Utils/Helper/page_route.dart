import 'package:flutter/material.dart';

Route createFadeRoute(Widget widget,{int duration = 200}) {
  return PageRouteBuilder(
    pageBuilder: (_, a1, a2) => FadeTransition(opacity: a1 ,child: widget),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.1, 0.1);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRoute(Widget widget,{int duration = 400}) {
  return PageRouteBuilder(
    pageBuilder: (_, a1, a2) => FadeTransition(opacity: a1 ,child: widget),
    transitionDuration: Duration(milliseconds: duration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      }
  );
}


pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => destination));
}

push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
          (Route<dynamic> route) => predict);
}