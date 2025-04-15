import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/competition.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/date_picker.dart';
import 'package:central_jogos/widgets/drop_down_list.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/snack_bar.dart';
import 'package:central_jogos/widgets/time_picker.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Competitions extends StatefulWidget {
  final bool editMode;

  const Competitions({this.editMode = false, super.key});

  @override
  State<Competitions> createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
  String? competitionName, mode;
  DateTime? startDate, endDate, startSubDate, endSubDate;
  TimeOfDay? time;
  static const List<String> modalities = ["Futebol", "Vôlei", "Xadrez",];

  void _advanceIfPossible(BuildContext context) {
    bool allFieldsAreFilled = competitionName != null 
      && competitionName!.trim().isNotEmpty && mode != null
      && startDate != null && endDate != null && startSubDate != null 
      && endSubDate != null && time != null;

    if(allFieldsAreFilled){
      bool datesMakeSense = (startDate!.isBefore(endDate!) ||
           startDate!.isAtSameMomentAs(endDate!)) &&
           (startSubDate!.isBefore(endSubDate!) ||
            startSubDate!.isAtSameMomentAs(endSubDate!));

      if(datesMakeSense){
        if(endSubDate!.isBefore(startDate!)){
          Competition competition = Competition(
            id: DBCrud(collectionPath: 'competitions', context: context).getId(),
            name: competitionName!, 
            mode: mode!, 
            location: "", 
            desc: "", 
            organizer: FirebaseAuth.instance.currentUser?.displayName??'',
            status: "Em breve",
            startDate: startDate!, 
            endDate: endDate!, 
            startSubDate: startSubDate!, 
            endSubDate: endSubDate!, 
            time: time!, 
            teams: {}, 
            matches: {},
          );

          if(widget.editMode){
            Navigator.pushNamed(
              context, 
              "/competitions2-edit",
              arguments: competition.toMap()
            );
          }

          else{
            Navigator.pushNamed(
              context, 
              "/competitions2",
              arguments: competition.toMap()
            );
          }

          return;
        }

        showSnackBar(
          context, "As inscrições precisam iniciar começar " 
          "do início das competições!"
        );

        return;
      }

      if(context.mounted){
        showSnackBar(
          context, 
          "O intervalo das datas está incorreto, certifique-se"
          "que as datas de início começam antes das datas de fim."
        );
      }

      return;
    }

    showSnackBar(
      context, 
      "Preencha todos os campos para prosseguir!" 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.editMode ? const TitleAppbar("Editar Competição") :
              const TitleAppbar("Criar Competições"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextfield(
                  hint: "Nome da Competição", 
                  onchanged: (value) {
                    
                      competitionName = value;
                  },
                ),
                DropDownList(
                  hint: "Selecione a Modalidade:",
                  items: modalities,
                  onChanged: (value) {
                    mode = value;
                  },
                ),
                DatePickerField(
                  label: Text("Data de Início"), 
                  onChanged: (value) {
                    startDate = value;
                  },
                ),
                DatePickerField(
                  label: Text("Data de Término"),
                  onChanged: (value) {
                    endDate = value;
                  },
                ),
                DatePickerField(
                  label: Text("Início das Inscrições"),
                  onChanged: (value) {
                    startSubDate = value;
                  },
                ),
                DatePickerField(
                  label: Text("Fim das Inscrições"),
                  onChanged: (value) {
                    endSubDate = value;
                  },
                ),
                TimePickerField(
                  label: Text("Horário"),
                  onchanged: (value) {
                    time = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
                  child: MainButton(
                    text: "Avançar", 
                    backgColor: AppColors.blue,
                    callBackFunc: () => _advanceIfPossible(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}