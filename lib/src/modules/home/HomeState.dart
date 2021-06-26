part of 'HomeBloc.dart';

enum HomeStatus { DashboardScreen, AboutScreen }

class HomeState extends Equatable {
  final HomeStatus status;

  HomeState({
    this.status = HomeStatus.DashboardScreen,
  });

  HomeState copyWith({HomeStatus? status}) {
    return HomeState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
