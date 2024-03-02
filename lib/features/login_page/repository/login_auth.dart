import 'package:ozimiz_project/network_service/network_service.dart';

class LoginAuth {
  login(String phoneNumber) async {
    final response = await NetworkService()
        .post(url: '/login', body: {'phone_number': phoneNumber});

    return response;
  }
}
