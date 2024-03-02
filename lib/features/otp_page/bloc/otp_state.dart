part of 'otp_bloc.dart';

enum OtpStatus { initial, loading, success, fail }

class OtpState extends Equatable {
  final OtpStatus status;
  final Object? exception;
  OtpState({this.status = OtpStatus.initial, this.exception});

  bool get isLoading => status == OtpStatus.loading;
  bool get isSuccess => status == OtpStatus.success;
  bool get isError => status == OtpStatus.fail;

  @override
  List<Object?> get props => [status, exception];

  OtpState copyWith({OtpStatus? status, Object? exception}) {
    return OtpState(
        status: status ?? this.status, exception: exception ?? this.exception);
  }
}
