import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozimiz_project/features/home_page/view/home_screen.dart';
import 'package:ozimiz_project/features/otp_page/bloc/otp_bloc.dart';
import 'package:ozimiz_project/features/otp_page/repository/otp_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
      width: 63.w,
      height: 72.h,
      textStyle: TextStyle(fontSize: 22.sp, color: Colors.black),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Color(0xFFD8DADC))));

  final otpBloc = OtpBloc(OtpAuth());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => otpBloc,
      child: Scaffold(
        body: BlocListener<OtpBloc, OtpState>(
          listener: (context, state) async {
            if (state.isSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLogged', true);
              // bool passed = true;
              // EventService.storegeInfo(passed);
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.exception}')));
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 145.h,
                ),
                Text(
                  'Введите код',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Text(
                  'Мы отправили SMS с кодом активации на ваш телефон ${widget.phoneNumber}',
                  style: TextStyle(
                      fontSize: 16.sp, color: Colors.black.withOpacity(0.7)),
                ),
                SizedBox(
                  height: 36.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Pinput(
                    controller: otpController,
                    length: 5,
                    defaultPinTheme: defaultPinTheme,
                    keyboardType: TextInputType.number,
                    closeKeyboardWhenCompleted: false,
                  ),
                ),
                SizedBox(
                  height: 52.h,
                ),
                Text(
                  'Отправить код cнова',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 34.h,
                ),
                SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                        color: Colors.black,
                        child: Text('Проверить'),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            otpBloc.add(OtpButton(
                                phoneNumber: widget.phoneNumber,
                                otp: otpController.text));
                          });
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
