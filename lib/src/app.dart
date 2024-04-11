import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_attendance_system/src/services/authentication.dart';

import 'package:geo_attendance_system/src/ui/pages/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: SplashScreenWidget(
                auth: new Auth(),
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
