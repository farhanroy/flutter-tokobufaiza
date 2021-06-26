part of 'HomeBloc.dart';

abstract class HomeEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class DashboardScreenEvent extends HomeEvent {}

class AboutScreenEvent extends HomeEvent {}