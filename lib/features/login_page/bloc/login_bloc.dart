import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ozimiz_project/features/login_page/repository/login_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginAuth repo;
  LoginBloc(this.repo) : super(LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      final response = await repo.login(event.phoneNumber);
      print(response.toString());
      if (response is Response<dynamic>) {
        emit(state.copyWith(
          status: LoginStatus.success,
        ));
      } else {
        emit(state.copyWith(
            exception: response.toString(), status: LoginStatus.fail));
      }
    });
  }
}
