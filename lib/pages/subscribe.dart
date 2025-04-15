import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/competition.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:central_jogos/widgets/drop_down_list.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({super.key});

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  Competition? competition;
  String? nickname, age, cpf, pos, wishedTeam; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args = ModalRoute.of(context)?.settings.arguments;

    competition = args as Competition;
  }

  bool _allFieldsArefilled() {
    return (
      nickname != null && age != null && cpf != null
        && pos != null && wishedTeam != null
    );
  }

  void addSubscriptionInCompetition() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if(currentUser == null) return;

    FirebaseFirestore firebase = FirebaseFirestore.instance;
    String userEmail = currentUser.email!.replaceAll(".", "_");
  
    DocumentReference? competitionDoc = firebase.collection('competitions')
      .doc(competition?.id);

    DocumentReference? userDoc = firebase.collection('users')
      .doc(userEmail);

    try{
      await competitionDoc.set({
        "subscribers" : FieldValue.arrayUnion([userEmail])
      },SetOptions(merge: true));

      await userDoc.set({
        "subscriptionsId" : FieldValue.arrayUnion([competition?.id]),
        "nickname" : nickname, 
        "age" : age,
        "cpf" : cpf,
        "pos" : pos, 
        "wishedTeam" : wishedTeam 
      },SetOptions(merge: true)); 
    }

    on FirebaseException catch(e){
      if(mounted){
        DBCrud(collectionPath: '', context: context).showExceptions(e.code);
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppbar("Inscrição"),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text(
                        "Nome que aparecerá na competição:", 
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomTextfield(
                      hint: "Nome Completo", 
                      prefixIcon: Icon(Icons.person),
                      onchanged: (value) {
                        nickname = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text(
                        "Idade:", 
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomTextfield(
                      hint: "Insira a idade", 
                      numericKeyBoard: true,
                      onchanged: (value) {
                        age = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text(
                        "Cpf:", 
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomTextfield(
                      hint: "Insira o Cpf (ex: 999.999.999-99):", 
                      prefixIcon: Icon(Icons.badge_sharp),
                      onchanged: (value) {
                        cpf = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text(
                        "Posição de afinidade:", 
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    DropDownList(
                      items: ["Posição 1", "Posição 2", "Posição 3", "Posição 4", "Posição 5"], 
                      hint: "Escolha uma posição",
                      onChanged: (value) {
                        pos = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text(
                        "Equipe desejada (organizador define):", 
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    DropDownList(
                      items: ["Equipe 1", "Equipe 2", "Equipe 3", "Equipe 4", "Equipe 5", ""], 
                      hint: "Selecione a equipe",
                      onChanged: (value) {
                        wishedTeam = value;
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 35.0, left: 35.0, top: 40),
                  child: MainButton(
                    text: "Confirmar Inscrição", backgColor: AppColors.blue, 
                    rightArrow: false, 
                    callBackFunc: () async {
                      bool? result = await confirmMessageDialog(
                        context, "Confirmar inscrição?"); 

                      if(result != null && result == true 
                        && context.mounted && _allFieldsArefilled()){
                        
                        addSubscriptionInCompetition();

                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                          context, "/competition-manage",
                          arguments: competition,
                        );
                      }

                      else if(result != null && result == false) {return;}

                      else{
                        if(context.mounted){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Preencha todos os campos!"),
                              duration: Duration(seconds: 3),                              
                            )
                          );
                        }
                      }
                    },
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