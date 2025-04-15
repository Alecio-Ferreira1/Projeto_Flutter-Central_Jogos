import 'dart:io';
import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/match.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:central_jogos/widgets/scoreboard.dart';
import 'package:central_jogos/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/widgets/date_picker.dart';
import 'package:central_jogos/widgets/drop_down_list.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/time_picker.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class Competitions3 extends StatefulWidget{
  const Competitions3({this.editMode = false, super.key});

  final bool editMode; 

  @override
  State<Competitions3> createState() => _Competitions3State();
}

class _Competitions3State extends State<Competitions3> {
  File? _image;
  bool _isPickingImage = false;
  DateTime? date;
  TimeOfDay? time;
  String? team1, team2, status, scoreTeam1, scoreTeam2;
  List<CompetitionMatch> matches = []; 
  List<String> teams = [];

  @override 
  void didChangeDependencies(){
    super.didChangeDependencies();

    if(widget.editMode){
      //query no BD para pegar os times desta comp (voltar aqui depois) 
    }

    getTeamsFromPrevPage();
  }

  void getTeamsFromPrevPage(){
    if(mounted){
      Map<String, dynamic> arguments = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      
      Map<String, dynamic> teamsFromMap = arguments['teams'];
      teams = List<String>.from(teamsFromMap.keys);
    }
  }

  Future<void> pickImage() async {
    if(_isPickingImage) return;
    _isPickingImage = true;

    try{
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if(image != null){
        setState(() {
          _image = File(image.path);
        });
      }
    }

    finally{
      _isPickingImage = false;
    }
  }

  void _cleanFields(){
    setState(() {
      date = null;
      time = null;
      team1 = null;
      team2 = null; 
      status = null; 
      scoreTeam1 = null; 
      scoreTeam2 = null;
    });
  }

  Future<bool> _saveData() async {
    if(!mounted) return false;
  
    Map<String, dynamic> arguments = 
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    Map<String, dynamic> matchesToMap = {};

    for(CompetitionMatch match in matches){
      matchesToMap[match.id] = match.toMap();
    }

    arguments.addAll({
      "imgPath" : _image?.path,
      "matches" : matchesToMap,
    });

    DBCrud db = DBCrud(collectionPath: 'competitions', context: context);
    return await db.create(arguments['id'] as String, arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.editMode? const TitleAppbar("Criar Competições")
              : const TitleAppbar("Editar Competições"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27.0),
                child: Text(
                  "Adicione as partidas:",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DatePickerField(
                label: Text("Data"),
                onChanged: (value) {
                  setState(() {
                    date = value;
                  });
                },
                useStartValue: true,
                startValue: date == null ? null : "${date?.day}/${date?.month}"
                  "/${date?.year}",
              ),
              TimePickerField(
                label: Text("Horário"),
                onchanged: (value) {
                  setState(() {
                    time = value;
                  });
                },
                useStartValue: true,
                startValue: time == null ? null : "${time?.hour}:${time?.minute}",
              ),
              DropDownList(
                items: [
                  "Em andamento", "Em breve", "Finalizado"
                ], 
                hint: "Status da partida",
                label: Text("Status da partida"),
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
                },
                useValue: true,
                value: status,
              ),
              DropDownList(
                items: teams, 
                hint: "Equipe mandante",
                label: Text("Equipe mandante"),
                onChanged: (value) {
                  setState(() {
                    team1 = value;
                  });
                },
                useValue: true,
                value: team1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "VS", 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              DropDownList(
                items: teams, 
                hint: "Equipe visitante",
                label: Text("Equipe visitante"),
                onChanged: (value) {
                  setState(() {
                    team2 = value;
                  });
                },
                useValue: true,
                value: team2,
              ),
              Visibility(
                visible: widget.editMode,
                child: Scoreboard(
                  match: CompetitionMatch(
                    id: "",
                    team1: "Mandante", 
                    team2: "Visitante", 
                    status: "", 
                    date: DateTime.now(), 
                    scoreTeam1: "", scoreTeam2: "",
                    time: TimeOfDay(hour: 0, minute: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35.0, left: 35.0, top: 15.0,),
                child: MainButton(
                  text: "Adicionar/Editar Partida",
                  buttonCanBeSmaller: true, 
                  backgColor: AppColors.blue,
                  rightArrow: false,
                  callBackFunc: () async {
                    bool allFieldsAreFilled = date != null && time != null &&
                         team1 != null && team2 != null  && status != null;
                    
                    if(allFieldsAreFilled){
                      Map<String, dynamic> arguments = 
                        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

                      DateTime endSubDate = (arguments['endSubDate'] as Timestamp).toDate();
                      DateTime competStartDate = (arguments['startDate'] as Timestamp).toDate();
                      DateTime competEndDate = (arguments['endDate'] as Timestamp).toDate();
                      
                      bool matchDateIsBeforeCompetEndDate = date!.isBefore(competEndDate) 
                           || date!.isAtSameMomentAs(competEndDate);

                      bool matchDateIsAfterEndSubDate = date!.isAfter(endSubDate);

                      if(team1 == team2){
                        showSnackBar(context, "Um time não pode disputar contra ele mesmo!");
                        return;
                      }
            
                      if(matchDateIsBeforeCompetEndDate && matchDateIsAfterEndSubDate){
                        matches.add(
                          CompetitionMatch(
                            id: DBCrud(collectionPath: 'competitions', context: context)
                            .getId(), 
                            team1: team1!, 
                            team2: team2!, 
                            status: status!, 
                            date: date!, 
                            time: time!
                          )
                        );

                        showSnackBar(context, "Partida adicionada!");
                        _cleanFields();
                        return;
                      }

                      String formatDate(DateTime date){
                        return "${date.day}/${date.month}/${date.year}";
                      }

                      await confirmMessageDialog(context, okClose: true,
                        "A data da partida deve estar no período de execução"
                        " da competição. Insira uma data entre (${formatDate(competStartDate)})"
                        " e (${formatDate(competEndDate)})."
                      );

                      return;
                    }

                    if(context.mounted){
                      showSnackBar(context, 
                        "Preencha todos os campos para adicionar uma partida!",
                      );
                    }
                  },
                ),
              ),
              Visibility(
                visible: widget.editMode,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35.0, left: 35.0, top: 25.0),
                  child: MainButton(
                    text: "Ver Partidas", 
                    backgColor: AppColors.blue,
                    rightArrow: false,
                    callBackFunc: () {
                      Navigator.pushNamed(context, "/edit_matches");
                    },
                  ),
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(right: 35.0, left: 35.0, top: 25.0,),
              child: MainButton(
                text: !widget.editMode ?  "Inserir foto da competição" : 
                      "Mudar Foto da Competição",
                backgColor: AppColors.blue,
                rightArrow:  false,
                callBackFunc: pickImage,
                buttonCanBeSmaller: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35.0, left: 35.0, top: 25.0, bottom: 30),
              child: MainButton(
                text: !widget.editMode ? "Criar Competição" : "Salvar Alterações", 
                backgColor: AppColors.blue,
                callBackFunc: () async{
                  bool? result = await confirmMessageDialog(
                    context, widget.editMode ? 
                    "Salvar alterações?" : "Criar Competição?"
                  );

                  if(context.mounted && result != null){ 
                    if(result){
                      bool opSucess = await _saveData();

                      if(context.mounted && opSucess){
                        showSnackBar(context, 
                        !widget.editMode ? "Competição criada com sucesso!"
                            : "Alterações salvas com sucesso!"
                        );
                      }
                    }

                    if(context.mounted){
                      if(widget.editMode){
                        Navigator.popUntil(context, ModalRoute.withName("/edit_competitions"));
                      }

                      else{
                        Navigator.popUntil(context, ModalRoute.withName("/competitions"));
                      }

                      Navigator.pushReplacementNamed(context, "/edit_competitions");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ); 
  }
}