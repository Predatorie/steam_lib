class SteamFriends {
  Friendslist friendslist;

  SteamFriends({this.friendslist});

  SteamFriends.fromJson(Map<String, dynamic> json) {
    friendslist = json['friendslist'] != null
        ? new Friendslist.fromJson(json['friendslist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friendslist != null) {
      data['friendslist'] = this.friendslist.toJson();
    }
    return data;
  }
}

class Friendslist {
  List<Friend> friends;

  Friendslist({this.friends});

  Friendslist.fromJson(Map<String, dynamic> json) {
    if (json['friends'] != null) {
      friends = new List<Friend>();
      json['friends'].forEach((v) {
        friends.add(new Friend.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friends != null) {
      data['friends'] = this.friends.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Friend {
  String steamid;
  String relationship;
  int friendSince;

  Friend({this.steamid, this.relationship, this.friendSince});

  Friend.fromJson(Map<String, dynamic> json) {
    steamid = json['steamid'];
    relationship = json['relationship'];
    friendSince = json['friend_since'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['steamid'] = this.steamid;
    data['relationship'] = this.relationship;
    data['friend_since'] = this.friendSince;
    return data;
  }
}
