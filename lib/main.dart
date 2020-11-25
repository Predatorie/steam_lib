import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:steam_lib/cubit/steam_cubit.dart';
import 'package:steam_lib/repositories/steam_repository.dart';
import 'package:steam_lib/services/formatter_service.dart';
import 'package:steam_lib/views/home_view.dart';
import 'package:steam_lib/views/splash_screen.dart';
import 'package:steam_lib/views/steam_login_view.dart';

void main() {
  final httpClient = http.Client();
  final formatterService = FormatterService();
  final steamRepository =
      SteamRepository(formatterService: formatterService, client: httpClient);

  runApp(SteameoApp(
    steamRepository: steamRepository,
  ));
}

class SteameoApp extends StatefulWidget {
  final SteamRepository steamRepository;

  const SteameoApp({Key key, @required this.steamRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  _SteameoAppState createState() => _SteameoAppState();
}

class _SteameoAppState extends State<SteameoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SteamLib Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => SteamLoginPage(),
        '/home': (context) => HomePage(),
      },
      home: BlocProvider(
        create: (_) => SteamCubit(widget.steamRepository),
        child: SteamLoginPage(),
      ),
    );
  }
}
