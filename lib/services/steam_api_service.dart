import 'package:steam_lib/models/steam_games.dart';
import 'package:steam_lib/models/steam_user.dart';

abstract class ISteamApiService {
  Future<ProfileDisplay> getUserProfileAsync(String steamId);
  Future<List<ProfileDisplay>> getFriendsProfileAsync(String steamId);
  Future<List<Game>> getGamesLibraryAsync(String steamId);
}
