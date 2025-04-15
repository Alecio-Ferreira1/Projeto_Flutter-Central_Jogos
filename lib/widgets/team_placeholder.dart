import 'package:central_jogos/widgets/info_card.dart';
import 'package:flutter/material.dart';

class TeamPlaceHolder extends StatelessWidget{
  final String title;
  final List<InfoCard> players; 

  const TeamPlaceHolder({required this.title, required this.players, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xEFDDDDDD),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            title, 
             style: const TextStyle(
              fontWeight: FontWeight.w600, 
              fontSize: 18,
             ),
          ),
          const SizedBox(height: 0,),
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: players,
          )    
        ],
      ),
    );
  }
}