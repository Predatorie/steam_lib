import 'package:steam_lib/models/steam_friends.dart';
import 'package:steam_lib/models/steam_games.dart';
import 'package:steam_lib/models/steam_user.dart';

abstract class ISteamApiService {
  Future<SteamUser> getUserProfileAsync(String steamId);
  Future<SteamFriends> getFriendsProfileAsync(String steamId);
  Future<SteamGames> getGamesLibraryAsync(String steamId);
}
