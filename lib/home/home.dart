import 'package:bloc01/home/bloc/home_bloc.dart';
import 'package:bloc01/services/bored_service.dart';
import 'package:bloc01/services/connectivity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          RepositoryProvider.of<BoredService>(context),
          RepositoryProvider.of<ConnectivityService>(context)
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Activity"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is HomeLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Activity: ${state.activity.activity}"),
                  Text("Type: ${state.activity.type}"),
                  Text("Participants: ${state.activity.participants}"),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
                      },
                      child: const Text("Load next"))
                ],
              );
            }
            if (state is HomeNoInternetState) {
              return const Center(
                child: Text("No internet :("),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
