import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_lib/cubit/steam_cubit.dart';

class SteamLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Steameo'),
      ),
      body: Container(
        child: BlocConsumer<SteamCubit, SteamState>(
          listener: (BuildContext context, state) {
            if (state is SteamUserError) {
              ScaffoldMessenger(
                child: Text(state.errorMessage),
              );
            }
          },
          builder: (BuildContext context, state) {
            if (state is SteamInitial) {
              return buildInitialInput();
            } else if (state is SteamUserLoading) {
              return buildLoading();
            } else if (state is SteamUserLoaded) {
              return null;
            } else {
              // (state is WeatherError)
              return buildInitialInput();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        label: Text('Connect'),
        icon: Icon(Icons.login),
        onPressed: () {},
      ),
    );
  }
}

Widget buildLoading() => Center(
      child: CircularProgressIndicator(),
    );

Widget buildInitialInput() {
  return Container(
    color: Colors.deepPurple,
  );
}
