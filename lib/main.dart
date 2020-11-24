import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:steam_lib/cubit/steam_cubit.dart';
import 'package:steam_lib/repositories/steam_repository.dart';
import 'package:steam_lib/services/formatter_service.dart';
import 'package:steam_lib/views/steam_login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SteamLib Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => SteamCubit(SteamRepository(
            client: http.Client(), formatterService: FormatterService())),
        child: SteamLoginView(),
      ),
    );
  }
}
