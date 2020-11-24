import 'package:meta/meta.dart';

class SteamGames {
  Library library;

  SteamGames({this.library});

  SteamGames.fromJson(Map<String, dynamic> json) {
    library = json['response'] != null
        ? new Library.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.library != null) {
      data['response'] = this.library.toJson();
    }
    return data;
  }
}

class Library {
  int gameCount;
  List<Games> games;

  Library({this.gameCount, this.games});

  Library.fromJson(Map<String, dynamic> json) {
    gameCount = json['game_count'];
    if (json['games'] != null) {
      games = new List<Games>();
      json['games'].forEach((v) {
        games.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_count'] = this.gameCount;
    if (this.games != null) {
      data['games'] = this.games.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Games {
  int appid;
  String name;
  int playtimeForever;
  String imgIconUrl;
  String imgLogoUrl;
  bool hasCommunityVisibleStats;

  Games(
      {@required this.appid,
      this.name,
      this.playtimeForever,
      this.imgIconUrl,
      this.imgLogoUrl,
      this.hasCommunityVisibleStats});

  Games.fromJson(Map<String, dynamic> json) {
    appid = json['appid'];
    name = json['name'];
    playtimeForever = json['playtime_forever'];
    imgIconUrl = json['img_icon_url'];
    imgLogoUrl = json['img_logo_url'];
    hasCommunityVisibleStats = json['has_community_visible_stats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appid'] = this.appid;
    data['name'] = this.name;
    data['playtime_forever'] = this.playtimeForever;
    data['img_icon_url'] = this.imgIconUrl;
    data['img_logo_url'] = this.imgLogoUrl;
    data['has_community_visible_stats'] = this.hasCommunityVisibleStats;
    return data;
  }
}

class Game {
  Game({@required id, @required name, playtimeForever, imgIconUrl, imgLogoUrl})
      : _appId = id,
        _name = name,
        _playtimeForever = playtimeForever,
        _imgIconUrl = imgIconUrl,
        _imgLogoUrl = imgLogoUrl;

  int _appId;
  int get id => _appId;

  String _name;
  String get name => _name;

  String _playtimeForever;
  String get playtimeForever => _playtimeForever;

  String _imgIconUrl;
  String get imgIconUrl => _imgIconUrl;

  String _imgLogoUrl;
  String get imgLogoUrl => _imgLogoUrl;
}
