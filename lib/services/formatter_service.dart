import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:steam_lib/secrets/secrets.dart';

class FormatterService {
  /// Formats the total number of minutes played "on record"
  String totalPlayTimeToString(int time) {
    var formattedTime = "No time on record.";
    if (time.isNaN || time == 0) {
      return formattedTime;
    }

    // The total number of minutes played "on record",
    // since Steam began tracking total playtime in early 2009.
    var d = Duration(minutes: time);

    var days = d.inDays;
    var hours = d.inHours;
    var minutes = d.inMinutes;

    if (days == 0 && hours == 0 && minutes == 0) {
      return formattedTime;
    }

    formattedTime = printDuration(aMinute * time);
    return formattedTime;
  }

  /// Formats the users current online state
  Text personaStateToText(int personastate) {
    // the user's current status. 0 - Offline, 1 - Online, 2 - Busy,
    // 3 - Away, 4 - Snooze, 5 - looking to trade, 6 - looking to play.

    switch (personastate) {
      case 0:
        return Text("Offline",
            style: TextStyle(color: Colors.grey, fontSize: 12.0));
      case 1:
        return Text(
          "Online",
          style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 12.0,
              fontWeight: FontWeight.bold),
        );
      case 2:
        return Text("Busy",
            style: TextStyle(color: Colors.red, fontSize: 12.0));
      case 3:
        return Text("Away",
            style: TextStyle(color: Colors.yellow, fontSize: 12.0));
      case 4:
        return Text("Snooze",
            style: TextStyle(color: Colors.blue, fontSize: 12.0));
      case 5:
        return Text("Looking for trade",
            style: TextStyle(color: Colors.orange, fontSize: 12.0));
      case 6:
        return Text("Looking to Play",
            style: TextStyle(color: Colors.greenAccent, fontSize: 12.0));
    }

    return Text("");
  }

  /// Formats the users last known logon date
  String lastLogToString(int lastLog) {
    var date = new DateTime.fromMillisecondsSinceEpoch(lastLog * 1000);

    var format = new DateFormat("yMd");
    var dateString = format.format(date);

    return "Last Online: $dateString";
  }

  String buildImageLogo(String appId, String url) =>
      '${Url.steamGamesImageEndPointUri}$appId/$url.jpg';
}
