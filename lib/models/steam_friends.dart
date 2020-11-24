import 'package:steam_lib/models/steam_user.dart';

class SteamFriends {
  List<SteamUser> players;

  SteamFriends({this.players});

  SteamFriends.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      players = new List<SteamUser>();
      json['players'].forEach((v) {
        players.add(new SteamUser.fromJson(v));
      });
    }
  }
}
