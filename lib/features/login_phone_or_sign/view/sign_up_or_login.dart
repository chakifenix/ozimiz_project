import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozimiz_project/features/login_page/view/login_screen.dart';
import 'package:ozimiz_project/features/sign_up_page/view/sign_up_page.dart';

class SignUpOrLogin extends StatelessWidget {
  const SignUpOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 31.h,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF0F3FB),
                  borderRadius: BorderRadius.circular(32.r)),
              child: Column(children: [
                SizedBox(
                  height: 87.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logoO.png'),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
                Image.asset('images/Text.png'),
                SizedBox(
                  height: 229.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  child: CupertinoButton(
                      padding: EdgeInsets.only(left: 28.w, right: 28.w),
                      borderRadius: BorderRadius.circular(36.r),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            CupertinoIcons.phone_fill,
                            color: Colors.black,
                          ),
                          Text(
                            'Продолжить с номера телефона',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16.sp),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      }),
                ),
                SizedBox(
                  height: 27.h,
                )
              ]),
            ),
            SizedBox(
              height: 41.h,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text('У вас уже есть аккаунт? Авторизоваться'))
          ],
        ),
      ),
    );
  }
}
