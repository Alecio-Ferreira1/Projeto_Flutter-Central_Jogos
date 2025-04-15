import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/competition.dart';
import 'package:central_jogos/widgets/competition_card.dart';
import 'package:central_jogos/widgets/bottom_navigation_bar.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({super.key});

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  List<CompetitionCard> cards = [];
  List<Competition> competitions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCompetitions();
  }

  void _getCompetitions() async {
    QuerySnapshot<Map<String, dynamic>>? competitionsCollection = await
    DBCrud(collectionPath: 'competitions', context: context).getCollection();

    if(competitionsCollection != null){
      setState(() {
        competitions = competitionsCollection.docs.map((document){
          return Competition.fromMap(document.data());
        }).toList();
      });
    }
  }

  List<Widget> _displayCards(){
    cards.clear();

    User? user = FirebaseAuth.instance.currentUser;
    String email = user?.email?.replaceAll('.', '_')??'';

    int getCategory(String mode){
      switch(mode){
        case "Futebol": return 2;
        case "Vôlei": return 1;
        case "Xadrez": return 0;
        default: return 3;
      }
    }

    for(Competition comp in competitions){
      if(comp.subscribers?.contains(email)??false){
        cards.add(
          CompetitionCard(
            category: getCategory(comp.mode), 
            title: comp.name, 
            date: comp.startDate,
            local: comp.location,
            cancelSubsOpt: true,
            onCancelSubs: () async {
              if(context.mounted){
                bool? result = await confirmMessageDialog(
                  context, "Você deseja cancelar essa inscrição?"
                );

                if(result == true && mounted){
                  cancelSubscription(comp.id);
                }
              }
            },
            onIconClick: () {
              Navigator.pushNamed(
                context, "/competition-manage",
                arguments: comp,
              );
            },
          )
        );
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar(
        "Minhas Inscrições", 
        callbackfunc: () {
          Navigator.pushNamed(context, "/explore");
        },
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.more_vert)
          ),
          const SizedBox(width: 20,),
        ], 
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: _displayCards(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}

void cancelSubscription(String competitionId) async {
  User? user = FirebaseAuth.instance.currentUser;

  if(user == null) return;

  String userEmail = user.email!.replaceAll('.', '_');

  await FirebaseFirestore.instance.collection('users')
    .doc(userEmail).update({
      "subscriptionsID" : FieldValue.arrayRemove([competitionId])
    }
  );

  await FirebaseFirestore.instance.collection('competitions')
    .doc(competitionId).update({
      "subscribers" : FieldValue.arrayRemove([userEmail])
    }
  );
}