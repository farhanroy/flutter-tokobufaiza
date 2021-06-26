import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'HomeEvent.dart';
part 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is DashboardScreenEvent) {
      yield HomeState(status: HomeStatus.DashboardScreen);
      print("AAAAAAAAAAAAAAAAAAAAAAAA");
    } else if (event is AboutScreenEvent) {
      yield HomeState(status: HomeStatus.AboutScreen);
    }
  }
}