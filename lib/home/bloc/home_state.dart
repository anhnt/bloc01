part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final BoredActivity activity;

  const HomeLoadedState(this.activity);

  @override
  List<Object?> get props => [activity];
}

class HomeNoInternetState extends HomeState {
  @override
  List<Object?> get props => [];
}
