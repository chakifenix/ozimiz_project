part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, fail }

class LoginState {
  LoginState({this.status = LoginStatus.initial, this.exception});
  final LoginStatus status;
  final Object? exception;

  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isError => status == LoginStatus.fail;

  LoginState copyWith({LoginStatus? status, Object? exception}) {
    return LoginState(
        status: status ?? this.status, exception: exception ?? this.exception);
  }
}
