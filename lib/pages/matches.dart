import 'package:central_jogos/entities/match.dart';
import 'package:central_jogos/widgets/match_placeholder.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class Matches extends StatelessWidget {
  final bool editMode;

  const Matches({this.editMode = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar("Partidas"),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              spacing: 10,
              children: [
                CompetitionPlaceholder(
                  match: CompetitionMatch(
                    team1: "Time 1", 
                    team2: "Time 2", 
                    status: "Em andamento", 
                    date: DateTime.now(), 
                    scoreTeam1: "3", 
                    scoreTeam2: "0",
                    time: TimeOfDay(hour: 17, minute: 40),
                    id: "1",
                  ),
                  editMode: editMode,
                ),
                CompetitionPlaceholder(
                  match: CompetitionMatch(
                    team1: "Time 3", 
                    team2: "Time 4", 
                    status: "Em breve", 
                    date: DateTime.now(), 
                    scoreTeam1: "", 
                    scoreTeam2: "",
                    id: "2",
                    time: TimeOfDay(hour: 20, minute: 10)
                  ),
                  editMode: editMode,
                ),
                CompetitionPlaceholder(
                  match: CompetitionMatch(
                    team1: "Time 5", 
                    team2: "Time 6", 
                    status: "Finalizado", 
                    date: DateTime.now(), 
                    scoreTeam1: "2", 
                    scoreTeam2: "1",
                    time: TimeOfDay(hour: 13, minute: 15),
                    id: "3",
                  ),
                  editMode: editMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}