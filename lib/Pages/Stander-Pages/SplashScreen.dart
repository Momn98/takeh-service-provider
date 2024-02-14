import 'package:flutter/material.dart';
import 'dart:async';

import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startApp();
    super.initState();
  }

  startApp() {
    Timer(Duration(seconds: 6), () {
      authProvider.checkIfUserLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      backgroundColor: AppColor.orange,
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                GlobalImage.splash_screen,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset(
                GlobalImage.splash_screen2,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),

      // Center(
      //   child: Image(
      //     image: LogoImage.logoNoBack,
      //     width: MediaQuery.of(context).size.width * 0.8,
      //   ),
      // ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            globalText('Powerd by codexal'),
            Image(image: LogoImage.codexal, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
