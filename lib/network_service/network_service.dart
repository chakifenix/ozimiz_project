import 'dart:async';
import 'package:dio/dio.dart';

class NetworkService {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://back-end.concierge-show.kz/api',
    connectTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 30),
  ));

  Future<dynamic> post({required String url, Object? body}) async {
    try {
      final response = await dio.post(url, data: body);
      print('api answer');
      return apiAnswerGenerator(response);
    } catch (e) {
      print('in catch');
      return errorAnswerGenerator(e);
    }
  }

  // Future<dynamic> afterLoginPost({required String url, Object? body}) async {
  //   var scopedToken = await EventService.getToken();
  //   var connectionId = await EventService.get();
  //   var roleId = await DirectorService.getRoleId();
  //   Map<String, dynamic> headersData = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $scopedToken',
  //     'X-Role-Id': roleId,
  //     'X-Connection-Id': connectionId
  //   };
  //   try {
  //     final response = await dio.post(url,
  //         data: body, options: Options(headers: headersData));
  //     print('api answer');
  //     return apiAnswerGenerator(response);
  //   } catch (e) {
  //     print('in catch');
  //     return errorAnswerGenerator(e);
  //   }
  // }

  // Future<dynamic> get(
  //     {required String url, Map<String, dynamic>? parameters}) async {
  //   var scopedToken = await DirectorService.getToken();
  //   var connectionId = await DirectorService.getConnectionId();
  //   var roleId = await DirectorService.getRoleId();
  //   Map<String, dynamic> headersData = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $scopedToken',
  //     'X-Role-Id': roleId,
  //     'X-Connection-Id': connectionId
  //   };
  //   try {
  //     final response = await dio.get(url,
  //         options: Options(headers: headersData), queryParameters: parameters);
  //     return apiAnswerGenerator(response);
  //   } catch (e) {
  //     return errorAnswerGenerator(e);
  //   }
  // }

  dynamic apiAnswerGenerator(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return response;
    } else {
      final Map<String, dynamic> answerMap = response.data;

      if (answerMap.containsKey('message')) {
        return answerMap['message'];
      } else {
        return 'Неизвестная ошибка';
      }
    }
  }

  String errorAnswerGenerator(dynamic err) {
    if (err is DioException) {
      return _handleError(err);
    } else {
      return 'Неизвестная ошибка';
    }
  }

  String _handleError(DioException error) {
    if (error.response == null) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Ошибка соеденения с сервером';
        case DioExceptionType.sendTimeout:
          return 'Время загрузки истекло';
        case DioExceptionType.receiveTimeout:
          return 'Время загрузки истекло';
        case DioExceptionType.badResponse:
          return 'Unknown error';
        case DioExceptionType.cancel:
          return 'Отмена запроса';
        default:
          return 'Неизвестная ошибка';
      }
    } else if (error.response!.statusCode == 401) {
      return error.response!.data['message'];
    } else {
      return 'Введите номер';
    }
  }
}
