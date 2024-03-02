part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, fail }

class HomeState extends Equatable {
  final String name;
  final String phoneNumber;
  final HomeStatus status;
  final String id;
  final Object? exception;

  const HomeState(
      {this.name = '',
      this.phoneNumber = '',
      this.id = '',
      this.status = HomeStatus.initial,
      this.exception});

  bool get isLoading => status == HomeStatus.loading;
  bool get isSuccess => status == HomeStatus.success;
  bool get isError => status == HomeStatus.fail;

  HomeState copyWith(
      {String? name,
      String? phoneNumber,
      HomeStatus? status,
      String? id,
      Object? exception}) {
    return HomeState(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        status: status ?? this.status,
        id: id ?? this.id,
        exception: exception ?? this.exception);
  }

  @override
  List<Object?> get props => [name, phoneNumber, status, id, exception];
}
