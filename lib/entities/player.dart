class Player {
  String name, position, userId, teamId;

  Player({
    required this.userId, required this.teamId,
    required this.name, required this.position, 
  });

  Map<String, dynamic> toMap(){
    return{
      "name" : name, 
      "position" : position,
      "userId" : userId,
      "teamId" : teamId
    };
  }

  factory Player.fromMap(Map<String, dynamic> map){
    return Player(
      userId: map['userId'], 
      teamId: map['teamId'], 
      name: map['name'], 
      position: map['position']
    );
  }
}