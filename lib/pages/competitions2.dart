import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/entities/team.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/drop_down_list.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/snack_bar.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class Competitions2 extends StatefulWidget {
  final bool editMode;

  const Competitions2({this.editMode = false, super.key});

  @override
  State<Competitions2> createState() => _Competitions2State();
}

class _Competitions2State extends State<Competitions2> {
  String? location, desc, team;
  Map<String, Team> teams = {};

  Widget crudButtons({
    void Function()? f1, 
    void Function()? f2,
    void Function()? f3,
  }){
    return Row(
      mainAxisAlignment: !widget.editMode ? MainAxisAlignment.center
        : MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: widget.editMode ? 0 : 1,
          child: MainButton(
            text: "Adicionar", 
            backgColor: AppColors.blue,
            buttonCanBeSmaller: widget.editMode,
            rightArrow: false,
            height: !widget.editMode ? 58 : 50,
            callBackFunc: f1,
          ),
        ),
        Visibility(
          visible: widget.editMode,
          child: MainButton(
            text: "Alterar", 
            backgColor: AppColors.blue,
            buttonCanBeSmaller: true,
            height: 50,
            callBackFunc: f2,
          ),
        ),
        Visibility(
          visible: widget.editMode,
          child: MainButton(
            text: "Excluir", 
            backgColor: AppColors.blue,
            buttonCanBeSmaller: true,
            height: 50,
            callBackFunc: f3,
          ),
        ),
      ],
    );
  }

  void _advanceIfPossible(){
    if(location != null && location!.trim().isNotEmpty && 
      desc != null && desc!.trim().isNotEmpty){

      Map<String, dynamic> teamsToMap = {}, arguments = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      
      for(Team team in teams.values){
        teamsToMap[team.name] = team.toMap();
      }

      arguments.addAll({
        "teams" : teamsToMap,
        "location" : location,
        "desc" : desc,
      });

      if(widget.editMode){
        Navigator.pushNamed(
          context, 
          "/competitions3-edit",
          arguments: arguments,
        );
      }

      else{
        Navigator.pushNamed(
          context, 
          "/competitions3",
          arguments: arguments,
        );
      }
    }

    else{
      showSnackBar(
        context, 
        "Preencha os campos de 'Localização' e 'descrição'."
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.editMode ? const TitleAppbar("Editar Competição") :
              const TitleAppbar("Criar Competições"),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5,),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 27.0),
                      child: Text(
                        !widget.editMode ?
                        "Adicione as equipes:" : 
                        "Selecione ou adicione uma equipe:",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.editMode,
                  child: const DropDownList(
                    items: ["Equipe 1", "Equipe 2", "Equipe 3", "Equipe 4", "Equipe 5"],
                    hint: "Nome da equipe",
                  ),
                ),
                CustomTextfield(
                  hint: "Nome da equipe",
                  onchanged: (value) {
                    setState(() {
                      team = value;
                    });
                  },
                  value: team,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.editMode? 27 : 35, right: widget.editMode? 27 : 35, 
                    bottom: 5, top: 5
                  ),
                  child: crudButtons(
                    f1: () {
                      if(team != null && teams[team] != null){
                        showSnackBar(context, 
                          "Um time com este nome ja foi adicionado!"
                        );

                        return;
                      }

                      if(team != null){
                        teams[team!] = Team(name: team!, players: {});
                        
                        setState(() {
                          team = null;
                        });
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: widget.editMode,
                  child: Column(
                    spacing: 3,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 27.0, top: 12),
                            child: Text(
                              "Selecione ou adicione um jogador: ",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const DropDownList(
                        hint: "Jogador:",
                        items: [
                          "Jogador 1", "Jogador 2", "Jogador 3", 
                          "Jogador 4", "Jogador 5", "Inscrito 1", 
                          "Inscrito 2", "Inscrito 3", "Inscrito 4", "Inscrito 5"
                        ],
                      ),
                      const DropDownList(
                        hint: "Equipe:",
                        items: [
                          "Equipe 1", "Equipe 2", "Equipe 3", 
                          "Equipe 4", "Equipe 5"
                        ],
                      ),
                      const DropDownList(
                        hint: "Posição:",
                        items: [
                          "Posição 1", "Posição 2", "Posição 3", 
                          "Posição 4", "Equipe 5"
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 27, right: 27, bottom: 15, top: 10),
                        child: crudButtons(),
                      ),
                    ],
                  ),
                ),
                Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 27.0, top: 10),
                            child: Text(
                              widget.editMode ? "Edite o Local da competição:" :
                                "Informe o Local da competição:",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomTextfield(
                        hint: !widget.editMode ? "Insira o Local" : "Altere o Local", 
                        prefixIcon: const Icon(Icons.location_on_sharp),
                        onchanged: (value) {
                          setState(() {
                            location = value;
                          });
                        },
                      ),
                      Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 27.0, top: 10),
                          child: Text(
                            widget.editMode ? "Altere a descrição (se for necessário):" :
                              "Adicione uma descrição:",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextfield(
                      hint: "Descrição do torneio/Competição", 
                      maxLines: 10,
                      onchanged: (value) {
                        setState(() {
                          desc = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35.0, left: 35.0, top: 15.0, bottom: 20),
              child: MainButton(
                text: "Avançar", 
                backgColor: AppColors.blue,
                callBackFunc: () => _advanceIfPossible(),
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