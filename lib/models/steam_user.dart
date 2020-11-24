import 'package:flutter/material.dart';

class Players {
  List<Profile> players;

  Players({this.players});

  Players.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      players = new List<Profile>();
      json['players'].forEach((v) {
        players.add(new Profile.fromJson(v));
      });
    }
  }
}

class Profile {
  String steamid;
  int communityvisibilitystate;
  int profilestate;
  String personaname;
  int lastlogoff;
  String profileurl;
  String avatar;
  String avatarmedium;
  String avatarfull;
  int personastate;
  String primaryclanid;
  int timecreated;
  int personastateflags;
  String loccountrycode;
  String locstatecode;
  int loccityid;

  Profile(
      {this.steamid,
      this.communityvisibilitystate,
      this.profilestate,
      this.personaname,
      this.lastlogoff,
      this.profileurl,
      this.avatar,
      this.avatarmedium,
      this.avatarfull,
      this.personastate,
      this.primaryclanid,
      this.timecreated,
      this.personastateflags,
      this.loccountrycode,
      this.locstatecode,
      this.loccityid});

  Profile.fromJson(Map<String, dynamic> json) {
    steamid = json['steamid'];
    communityvisibilitystate = json['communityvisibilitystate'];
    profilestate = json['profilestate'];
    personaname = json['personaname'];
    lastlogoff = json['lastlogoff'];
    profileurl = json['profileurl'];
    avatar = json['avatar'];
    avatarmedium = json['avatarmedium'];
    avatarfull = json['avatarfull'];
    personastate = json['personastate'];
    primaryclanid = json['primaryclanid'];
    timecreated = json['timecreated'];
    personastateflags = json['personastateflags'];
    loccountrycode = json['loccountrycode'];
    locstatecode = json['locstatecode'];
    loccityid = json['loccityid'];
  }
}

class ProfileDisplay {
  String communityvisibilitystate;
  String profilestate;
  String personaname;
  String lastlogoff;
  String profileurl;
  String avatar;
  String avatarmedium;
  String avatarfull;
  Text personastate;
  String timecreated;
  String personastateflags;
  String loccountrycode;
  String locstatecode;
  int lastLogOffTimeStamp;

  ProfileDisplay(
      {@required id,
      this.communityvisibilitystate,
      this.profilestate,
      this.personaname,
      this.lastlogoff,
      this.profileurl,
      this.avatar,
      this.avatarfull,
      this.avatarmedium,
      this.loccountrycode,
      this.locstatecode,
      this.personastate,
      this.personastateflags,
      this.timecreated,
      this.lastLogOffTimeStamp})
      : _steamid = id;

  String _steamid;
  String get id => _steamid;
}
