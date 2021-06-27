part of 'HomeBloc.dart';

abstract class HomeEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class ProductEvent extends HomeEvent {}

class SettingEvent extends HomeEvent {}