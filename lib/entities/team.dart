import 'package:central_jogos/entities/player.dart';

class Team {
  String name;
  Map<String, Player> players;

  Team({required this.name, required this.players});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> players = {};

    for(Player player in this.players.values){
      players[player.userId] = player.toMap();
    }

    return{
      "name" : name, 
      "players" : players,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map){
    Map<String, Player> players = {};

    if(map['players'] is Map<String, dynamic>){
      for(var player in (map['players'] as Map<String, dynamic>).values){
        players[player['userId']] = Player.fromMap(player);
      }
    }

    return Team(
      name: map['name'],
      players: players
    );
  }
}