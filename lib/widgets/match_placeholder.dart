import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/entities/match.dart';
import 'package:central_jogos/widgets/clickable_text.dart';
import 'package:central_jogos/widgets/scoreboard.dart';
import 'package:flutter/material.dart';

class CompetitionPlaceholder extends StatelessWidget{
  final CompetitionMatch match;
  final bool editMode;

  const CompetitionPlaceholder({
    required this.match, required this.editMode,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xEFDDDDDD),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 20,
            children: [
              RichText(
                text: TextSpan(
                  text: "Data: ",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${match.date.day}/${match.date.month}/${match.date.year}",
                      style: TextStyle(fontSize: 14, color: AppColors.blue), 
                    ),
                  ], 
                ), 
              ),
              RichText(
                text: TextSpan(
                  text: "Horário: ",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${match.time.hour}:${match.time.minute}",
                      style: TextStyle(fontSize: 14, color: AppColors.blue), 
                    ),
                  ], 
                ), 
              ),
            ],
          ),
          Scoreboard(
            match: match,
            readOnly: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Status da partida: ",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: match.status,
                      style: TextStyle(fontSize: 14, color: AppColors.blue), 
                    ),
                  ], 
                ), 
              ),
              Visibility(
                visible: editMode,
                child: ClickableText(
                  activeColor: Colors.purpleAccent, 
                  content: "Editar", 
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
              Visibility(
                visible: editMode,
                child: ClickableText(
                  activeColor: Colors.purpleAccent, 
                  content: "Excluir", 
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}