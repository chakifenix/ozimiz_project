import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozimiz_project/features/login_phone_or_sign/view/sign_up_or_login.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 110.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logoOzimiz.png'),
            ],
          ),
          SizedBox(
            height: 179.h,
          ),
          Image.asset('images/Text.png'),
          SizedBox(
            height: 169.h,
          ),
          Container(
              width: 353.w,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.r)),
              child: CupertinoButton(
                  child: Text(
                    'Создать аккаунт',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpOrLogin()));
                  })),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            width: 353.w,
            child: CupertinoButton(
                color: Colors.black,
                child: Text(
                  'Войти',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpOrLogin()));
                }),
          )
        ],
      ),
    );
  }
}
