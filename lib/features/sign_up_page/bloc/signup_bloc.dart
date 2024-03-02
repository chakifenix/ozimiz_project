import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozimiz_project/features/sign_up_page/bloc/signup_state.dart';
import 'package:ozimiz_project/features/sign_up_page/repository/signup_repo.dart';

part 'signup_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpAuth repo;
  SignUpBloc(this.repo) : super(SignUpState()) {
    on<SignUpButtonPressed>((event, emit) async {
      final response = await repo.signUp(event.fullName, event.phoneNumber);
      print(response.toString());
      if (response is Response<dynamic>) {
        emit(state.copyWith(
          status: SignUpStatus.success,
        ));
      } else {
        emit(state.copyWith(
            exception: response.toString(), status: SignUpStatus.fail));
      }
    });
  }
}
