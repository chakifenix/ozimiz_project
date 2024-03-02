part of 'signup_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  const SignUpButtonPressed(
      {required this.fullName, required this.phoneNumber});
  final String fullName;
  final String phoneNumber;
}
