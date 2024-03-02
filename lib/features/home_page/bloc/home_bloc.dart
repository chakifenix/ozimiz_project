import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozimiz_project/service/local_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<LoadHomeEvent>((event, emit) async {
      // TODO: implement event handler
      String? name = await EventService.getName();
      String? phoneNumber = await EventService.getPhoneNumber();
      String? id = await EventService.getId();
      emit(state.copyWith(
          name: name,
          phoneNumber: phoneNumber,
          id: id,
          status: HomeStatus.success));
    });
  }
}
