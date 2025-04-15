import 'package:central_jogos/entities/competition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final Competition competition;
  final User? _user = FirebaseAuth.instance.currentUser;

  SimpleCard({required this.competition, super.key});

  String _chooseDefaultImage(String mode){
    switch(mode){
      case "Futebol": return "assets/img/soccer.jpg";
      case "Vôlei": return "assets/img/volleyball.jpg";
      case "Xadrez": return "assets/img/chess.jpg";
      default: return "assets/icons/placeholder.png";
    }
  }

  bool _userIsSubscribed(){
    for(String sub in competition.subscribers??[]){
      if(sub == (_user?.email)?.replaceAll('.', '_')){
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        late String route;

        if(competition.organizer == _user?.displayName){
          route = "/competition-organizer";
        }

        else if(_userIsSubscribed()){
          route = "/competition-manage";
        }

        else{
          route = "/competition-subscribe";
        }

        Navigator.pushNamed(context, route, arguments: competition);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      competition.imgPath ?? _chooseDefaultImage(competition.mode),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(competition.name, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on), 
                    const SizedBox(width: 5),
                    Text(competition.location)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
