import 'package:bloc01/home/home.dart';
import 'package:bloc01/services/bored_service.dart';
import 'package:bloc01/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => BoredService()),
            RepositoryProvider(create: (context) => ConnectivityService())
          ],
          child: const HomePage(),
        ));
  }
}
