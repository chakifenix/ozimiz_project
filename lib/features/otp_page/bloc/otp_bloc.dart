import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozimiz_project/features/otp_page/repository/otp_auth.dart';
import 'package:ozimiz_project/models/info_model.dart';
import 'package:ozimiz_project/service/local_service.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpAuth repo;
  OtpBloc(this.repo) : super(OtpState()) {
    on<OtpButton>((event, emit) async {
      // TODO: implement event handler
      final response = await repo.otpAuth(event.phoneNumber, event.otp);

      if (response is Response<dynamic>) {
        var data = jsonDecode(response.toString());
        final infoModel = UserInfo.fromJson(data);
        final String fullName = infoModel.data.fullName;
        final String token = infoModel.token;
        final String updatedAt = '${infoModel.data.updatedAt}';
        final String createdAt = '${infoModel.data.createdAt}';
        final String phoneNumber = infoModel.data.phoneNumber;
        final int id = infoModel.data.id;
        print(id);
        await EventService.storeInfo(
            fullName, phoneNumber, token, updatedAt, createdAt, id);
        emit(state.copyWith(
          status: OtpStatus.success,
        ));
      } else {
        emit(state.copyWith(
            exception: response.toString(), status: OtpStatus.fail));
      }
    });
  }
}
