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
              return buildInitialInput(context);
            } else if (state is SteamUserLoading) {
              return buildLoading();
            } else if (state is SteamUserLoaded) {
              return buildLoadedState(state);
            } else {
              // (state is WeatherError)
              return buildInitialInput(context);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        label: Text('Connect'),
        icon: Icon(Icons.games),
        onPressed: () async {
          final steamCubit = context.read<SteamCubit>();
          await steamCubit.getUserProfile('76561197985266024');
        },
      ),
    );
  }
}

Widget buildLoading() => Center(
      child: CircularProgressIndicator(),
    );

Widget buildInitialInput(BuildContext context) {
  return Container(
    color: Colors.deepPurple,
  );
}

Widget buildLoadedState(SteamUserLoaded state) {
  return Container(
    color: Colors.deepPurple,
    child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.network(state.steamUser.avatarmedium),
          Text(
            state.steamUser.personaname,
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          Text(
            state.steamUser.lastlogoff,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    ),
  );
}
