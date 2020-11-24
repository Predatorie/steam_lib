import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:steam_lib/exceptions/network_exception.dart';
import 'package:steam_lib/models/steam_games.dart';
import 'package:steam_lib/models/steam_user.dart';
import 'package:steam_lib/secrets/secrets.dart';
import 'package:steam_lib/services/formatter_service.dart';
import 'package:steam_lib/services/steam_api_service.dart';

class SteamRepository implements ISteamApiService {
  final http.Client client;
  final FormatterService formatterService;

  SteamRepository({@required this.formatterService, @required this.client});

  @override
  Future<List<ProfileDisplay>> getFriendsProfileAsync(String steamId) async {
    // get a list of friends
    var url = "${Url.friendsBaseUrl}$steamId${Url.steamEndUrl}";

    var result = await client
        .get(Uri.encodeFull(url))
        .then((result) => result.body)
        .then(json.decode)
        .then((f) => Players.fromJson(f))
        .catchError((err) => throw NetworkException(err.toString()));

    if (result.players == null || result.players.length == 0) {
      throw (NetworkException('No friends returned.'));
    }

    var players = result.players;
    var friends = List<ProfileDisplay>();

    // iterate over friends to get their profile
    for (var player in players) {
      var profile = await getUserProfileAsync(player.steamid);
      if (profile != null) {
        friends.add(profile);
      }
    }

    friends
        .sort((a, b) => b.lastLogOffTimeStamp.compareTo(a.lastLogOffTimeStamp));

    return friends;
  }

  @override
  Future<List<Game>> getGamesLibraryAsync(String steamId) async {
    var url = "${Url.ownedGamesUri}$steamId${Url.steamEndUrl}";

    List<Game> list = [];

    var result = await client
        .get(Uri.encodeFull(url))
        .then((result) => result.body)
        .then(json.decode)
        .then((json) => json["response"])
        .then((games) => SteamGames.fromJson(games))
        .catchError((err) => throw (NetworkException(err.toString())));

    var library = result.library;
    if (library == null || library.games?.length == 0) {
      // Likely the user does not have a public profile or we lost connection
      throw (NetworkException(
          'Unable to retrieve games library. Profile might not be public'));
    }

    // Sort games my most time played
    library.games
        .sort((a, b) => b.playtimeForever.compareTo(a.playtimeForever));

    for (var game in library.games) {
      // videos, sdks might not have an image so filter those
      if (game.imgLogoUrl == null ||
          game.imgLogoUrl.isEmpty ||
          game.imgIconUrl == null ||
          game.imgIconUrl.isEmpty) {
        continue;
      }

      var thisGame = Game(
          id: game.appid,
          name: game.name,
          imgIconUrl: formatterService.buildImageLogo(
              game.appid.toString(), game.imgIconUrl),
          imgLogoUrl: formatterService.buildImageLogo(
              game.appid.toString(), game.imgLogoUrl),
          playtimeForever:
              formatterService.totalPlayTimeToString(game.playtimeForever));

      list.add(thisGame);
    }

    return list;
  }

  @override
  Future<ProfileDisplay> getUserProfileAsync(String steamId) async {
    var url = "${Url.baseUrlProfile}$steamId${Url.steamEndUrl}";

    var result = await client
        .get(Uri.encodeFull(url))
        .then((result) => result.body)
        .then(json.decode)
        .then((json) => json["response"])
        .then((profile) => Players.fromJson(profile))
        .catchError((err) => throw (NetworkException(err.toString())));

    if (result.players?.length == 0) {
      throw (NetworkException('Connection failed. Please try again.'));
    }

    var display = ProfileDisplay(id: result.players[0].steamid)
      ..avatar = result.players[0].avatar
      ..avatarmedium = result.players[0].avatarmedium
      ..avatarfull = result.players[0].avatarfull
      ..communityvisibilitystate =
          result.players[0].communityvisibilitystate.toString()
      ..lastlogoff =
          formatterService.lastLogToString(result.players[0].lastlogoff)
      ..lastLogOffTimeStamp = result.players[0].lastlogoff
      ..loccountrycode = result.players[0].loccountrycode
      ..locstatecode = result.players[0].locstatecode
      ..personaname = result.players[0].personaname
      ..personastate =
          formatterService.personaStateToText(result.players[0].personastate)
      ..personastateflags = result.players[0].personastateflags.toString();

    return display;
  }
}
