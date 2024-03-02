import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ozimiz_project/features/login_page/bloc/login_bloc.dart';
import 'package:ozimiz_project/features/login_page/repository/login_auth.dart';
import 'package:ozimiz_project/features/otp_page/view/otp_screen.dart';
import 'package:ozimiz_project/features/sign_up_page/view/sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  final loginBloc = LoginBloc(LoginAuth());

  final maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              final String phoneNumber =
                  phoneController.text.replaceAll(RegExp(r'\D'), '');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpScreen(
                            phoneNumber: phoneNumber,
                          )));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.exception}')));
            }
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 48.h, left: 20.w, right: 20.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 145.h,
                      ),
                      Text(
                        'Авторизация',
                        style: TextStyle(
                            fontSize: 26.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 44.h,
                      ),
                      Text('Номер телефона'),
                      SizedBox(
                        height: 6.h,
                      ),
                      CupertinoTextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [maskFormatter],
                        padding: EdgeInsets.only(
                            top: 18.h, bottom: 18.h, left: 16.w, right: 16.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFD8DADC))),
                        placeholder: '+7 777 777 7777',
                      ),
                      SizedBox(
                        height: 31.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                            color: Colors.black,
                            child: Text(
                              'Войти',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              final String phoneNumber = phoneController.text
                                  .replaceAll(RegExp(r'\D'), '');
                              setState(() {
                                loginBloc.add(LoginButtonPressed(
                                    phoneNumber: phoneNumber));
                              });

                              // print(fullNameController.text);
                              // print(phoneNumberController.text.substring(1));
                            }),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text('У вас нету аккаунта? Зарегистрироваться')),
                ]),
          ),
        ),
      ),
    );
  }
}
