part of 'HomeBloc.dart';

enum HomeStatus { ProductScreen, SettingScreen }

class HomeState extends Equatable {
  final HomeStatus status;

  HomeState({
    this.status = HomeStatus.ProductScreen,
  });

  HomeState copyWith({HomeStatus? status}) {
    return HomeState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
