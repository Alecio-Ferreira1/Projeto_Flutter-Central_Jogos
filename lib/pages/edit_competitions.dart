import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/widgets/competition_card.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class EditCompetitions extends StatelessWidget {
  const EditCompetitions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppbar("Editar Competições"),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 15, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "Competições cadastradas: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                CompetitionCard(
                  category: 0, 
                  title: "Campeonato de Xadrez", 
                  date: DateTime.now(),
                  editMode: true,
                  onDelete: () async{
                    bool? result = await confirmMessageDialog(
                      context, "Você deseja mesmo excluir essa competição?", 
                      messagefontColor: Colors.red, buttonFontColor: Colors.black
                    );
                  },
                ),
                CompetitionCard(
                  category: 2, 
                  title: "Campeonato de Futebol", 
                  date: DateTime.now(),
                  editMode: true,
                  onDelete: () async{
                    bool? result = await confirmMessageDialog(
                      context, "Você deseja mesmo excluir essa competição?", 
                      messagefontColor: Colors.red, buttonFontColor: Colors.black
                    );
                  },
                ),
                CompetitionCard(
                  category: 1, 
                  title: "Campeonato de Vôlei", 
                  date: DateTime.now(),
                  editMode: true,
                  onDelete: () async{
                    bool? result = await confirmMessageDialog(
                      context, "Você deseja mesmo excluir essa competição?", 
                      messagefontColor: Colors.red, buttonFontColor: Colors.black
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 20, bottom: 15),
              child: MainButton(
                text: "Voltar para explorar", 
                backgColor: AppColors.blue,
                rightArrow: false,
                callBackFunc: () {
                  Navigator.popUntil(context, ModalRoute.withName("/explore"));
                  Navigator.pushReplacementNamed(context, "/explore");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}