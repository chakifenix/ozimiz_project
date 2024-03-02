import 'package:ozimiz_project/network_service/network_service.dart';

class SignUpAuth {
  signUp(String fullName, String phoneNumber) async {
    final response = await NetworkService().post(
        url: '/register',
        body: {'full_name': fullName, 'phone_number': phoneNumber});

    return response;
  }
}
