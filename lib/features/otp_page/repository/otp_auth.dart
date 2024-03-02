import 'package:ozimiz_project/network_service/network_service.dart';

class OtpAuth {
  otpAuth(String phoneNumber, String otp) async {
    final response = await NetworkService()
        .post(url: '/verify', body: {'phone_number': phoneNumber, 'code': otp});
    return response;
  }
}
