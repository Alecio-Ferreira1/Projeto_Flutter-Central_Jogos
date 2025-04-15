import 'package:central_jogos/entities/match.dart';
import 'package:central_jogos/entities/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Competition{
  String name, mode, location, desc, id, organizer, status;
  DateTime startDate, endDate, startSubDate, endSubDate;
  TimeOfDay time;
  Map<String, Team> teams;
  Set<String>? subscribers;
  Map<String, CompetitionMatch> matches;
  String? imgPath;

  Competition({
    required this.id, required this.name, required this.mode,
    required this.location, required this.desc,
    required this.startDate, required this.endDate,
    required this.startSubDate, required this.endSubDate,
    required this.time, required this.teams, 
    required this.matches, this.imgPath, this.subscribers,
    required this.organizer, required this.status,
  });

  Map<String, dynamic> toMap(){
    Map<String, dynamic> teams = {}, matches = {};

    this.teams.forEach((key, team){
      teams[key] = team.toMap();
    });

    this.matches.forEach((key, match){
      matches[key] = match.toMap();
    });

    return {
      "id" : id,
      "organizer" : organizer,
      "name" : name, 
      "mode" : mode,
      "location" : location,
      "desc" : desc,
      "status" : status,
      "startDate" : Timestamp.fromDate(startDate), 
      "endDate" : Timestamp.fromDate(endDate), 
      "startSubDate" : Timestamp.fromDate(startSubDate), 
      "endSubDate" : Timestamp.fromDate(endSubDate),
      "time" : "${time.hour}:${time.minute}",
      "teams" : teams,
      "subscribers" : subscribers?.toList(),
      "matches" : matches,
      "imgPath" : imgPath
    };
  }

  factory Competition.fromMap(Map<String, dynamic> map){
    Map<String, Team> teams = {};
    Map<String, CompetitionMatch> matches = {};

    for(var team in (map['teams'] as Map<String, dynamic>).values){
      teams[team['name']] = Team.fromMap(team);
    }

    for(var match in (map['matches'] as Map<String, dynamic>).values){
      matches[match['id']] = CompetitionMatch.fromMap(match);
    }

    return Competition(
      id : map['id'],
      name: map['name'], 
      mode: map['mode'], 
      location: map['location'], 
      desc: map['desc'], 
      organizer: map['organizer'],
      status: map['status'],
      startDate: (map['startDate'] as Timestamp).toDate(), 
      endDate: (map['endDate'] as Timestamp).toDate(), 
      startSubDate: (map['startSubDate'] as Timestamp).toDate(), 
      endSubDate: (map['endSubDate'] as Timestamp).toDate(), 
      time: TimeOfDay(
        hour: int.tryParse((map['time'] as String).split(":")[0]) ?? 0,
        minute: int.tryParse((map['time'] as String).split(":")[1]) ?? 0
      ),
      teams: teams, 
      subscribers : List<String>.from(map['subscribers'] ?? []).toSet(),
      matches: matches,
      imgPath: map['imgPath']
    );
  }
}