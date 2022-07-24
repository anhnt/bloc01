import 'package:bloc/bloc.dart';
import 'package:bloc01/services/bored_service.dart';
import 'package:bloc01/services/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;
  HomeBloc(this._boredService, this._connectivityService) : super(HomeLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('no internet');
        add(NoInternetEvent());
      } else {
        print('yes internet');
        add(LoadApiEvent());
      }
    });
    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final activity = await _boredService.getActivity();
      emit(HomeLoadedState(activity));
    });
    on<NoInternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }
}
