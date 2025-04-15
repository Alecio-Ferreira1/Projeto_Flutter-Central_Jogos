import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompetitionMatch {
  String team1, team2, status, id;
  String? scoreTeam1, scoreTeam2;
  DateTime date;
  TimeOfDay time;

  CompetitionMatch({
    required this.id, required this.team1, required this.team2, 
    required this.status, required this.date, 
    this.scoreTeam1, this.scoreTeam2, required this.time,
  });

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "team1" : team1, 
      "team2" : team2,
      "status" : status,
      "scoreTeam1" : scoreTeam1,
      "scoreTeam2" : scoreTeam2,
      "date" : Timestamp.fromDate(date),
      "time" : "${time.hour}:${time.minute}"
    };
  }

  factory CompetitionMatch.fromMap(Map<String, dynamic> map){
    return CompetitionMatch(
      id : map['id'],
      team1: map['team1'], 
      team2: map['team2'], 
      status: map['status'], 
      date: (map['date'] as Timestamp).toDate(),
      time: TimeOfDay(
        hour: int.tryParse((map['time'] as String).split(":")[0]) ?? 0,
        minute: int.tryParse((map['time'] as String).split(":")[1]) ?? 0
      ),
      scoreTeam1: map['scoreTeam1'],
      scoreTeam2: map['scoreTeam2']
    );
  }
}