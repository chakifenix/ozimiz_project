import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozimiz_project/features/home_page/view/home_screen.dart';
import 'package:ozimiz_project/features/login_phone_or_sign/view/sign_up_or_login.dart';
import 'package:ozimiz_project/features/qr_scan_page/view/qr_scan_screen.dart';
import 'package:ozimiz_project/features/sign_up_page/view/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool isLogged;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // var value = await EventService.getIsLogged();
  isLogged = prefs.getBool('isLogged') ?? false;
  // isLogged = value?.toLowerCase() == 'true';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393.0, 852.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: (isLogged) ? HomeScreen() : SignUpOrLogin(),
          );
        });
  }
}
