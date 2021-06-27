import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'HomeEvent.dart';
part 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ProductEvent) {
      yield HomeState(status: HomeStatus.ProductScreen);
    } else if (event is SettingEvent) {
      yield HomeState(status: HomeStatus.SettingScreen);
    }
  }
}