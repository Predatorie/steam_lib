import 'package:flutter/material.dart';
import 'package:steam_lib/models/steam_user.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileDisplay profile = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.personaname),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
          child: _HomeView(
        profile: profile,
      )),
    );
  }
}

class _HomeView extends StatelessWidget {
  final ProfileDisplay profile;

  const _HomeView({
    Key key,
    @required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildLoadedState(profile);
  }
}

Widget _buildLoadedState(ProfileDisplay profile) {
  return Container(
    color: Colors.deepPurple,
    child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.network(profile.avatarmedium),
          Text(
            profile.personaname,
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          Text(
            profile.lastlogoff,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    ),
  );
}
