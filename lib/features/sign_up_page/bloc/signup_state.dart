enum SignUpStatus { initial, loading, success, fail }

class SignUpState {
  SignUpState({this.status = SignUpStatus.initial, this.exception});
  final SignUpStatus status;
  final Object? exception;

  bool get isLoading => status == SignUpStatus.loading;
  bool get isSuccess => status == SignUpStatus.success;
  bool get isError => status == SignUpStatus.fail;

  SignUpState copyWith({SignUpStatus? status, Object? exception}) {
    return SignUpState(
        status: status ?? this.status, exception: exception ?? this.exception);
  }
}
