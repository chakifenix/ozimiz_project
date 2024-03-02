part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpButton extends OtpEvent {
  OtpButton({required this.phoneNumber, required this.otp});

  final String phoneNumber;
  final String otp;
}
