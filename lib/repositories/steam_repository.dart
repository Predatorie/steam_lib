import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:steam_lib/exceptions/network_exception.dart';
import 'package:steam_lib/models/steam_friends.dart';
import 'package:steam_lib/models/steam_games.dart';
import 'package:steam_lib/models/steam_user.dart';
import 'package:steam_lib/secrets/secrets.dart';
import 'package:steam_lib/services/steam_api_service.dart';

class SteamRepository implements ISteamApiService {
  final Dio dio;

  SteamRepository({@required this.dio});

  @override
  Future<SteamFriends> getFriendsProfileAsync(String steamId) {
    // TODO: implement getFriendsProfile
    throw UnimplementedError();
  }

  @override
  Future<SteamGames> getGamesLibraryAsync(String steamId) {
    // TODO: implement getGamesLibrary
    throw UnimplementedError();
  }

  @override
  Future<SteamUser> getUserProfileAsync(String steamId) async {
    var url = "${Url.baseUrlProfile}$steamId${Url.steamEndUrl}";

    final response =
        await dio.get(url).catchError((e) => throw (NetworkException()));

    final profile = SteamUser.fromJson(response as Map<String, dynamic>);
    return profile;
  }
}
