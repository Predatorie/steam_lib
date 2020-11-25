import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_lib/cubit/steam_cubit.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steamCubit = BlocProvider.of<SteamCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        backgroundColor: Colors.deepPurple,
      ),
      body: buildLoadedState(steamCubit.state),
    );
  }
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
