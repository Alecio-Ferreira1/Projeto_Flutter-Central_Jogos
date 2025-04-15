import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/competition.dart';
import 'package:central_jogos/widgets/competition_card.dart';
import 'package:central_jogos/widgets/bottom_navigation_bar.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:central_jogos/widgets/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewCompetitions extends StatefulWidget {
  const ViewCompetitions({super.key});

  @override
  State<ViewCompetitions> createState() => _ViewCompetitionsState();
}

class _ViewCompetitionsState extends State<ViewCompetitions> {
  final FocusNode _focusNode = FocusNode();
  bool _searchBarVisible = false; 
  List<CompetitionCard> cards = [];
  List<Competition> competitions = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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

  String _getRoute(User user, Competition comp){
    String email = user.email?.replaceAll('.', '_')??'';

    if(comp.organizer == user.displayName){
      return "/competition-organizer";
    }

    else if(comp.subscribers?.contains(email)??false){
      return "/competition-manage";
    }

    return "/competition-subscribe";
  }

  List<Widget> _displayCards(){
    cards.clear();

    int getCategory(String mode){
      switch(mode){
        case "Futebol": return 2;
        case "Vôlei": return 1;
        case "Xadrez": return 0;
        default: return 3;
      }
    }

    User? user = FirebaseAuth.instance.currentUser;

    for(Competition comp in competitions){
      if(comp.status == "Finalizado") continue;

      cards.add(
        CompetitionCard(
          category: getCategory(comp.mode), 
          title: comp.name, 
          date: comp.startDate,
          local: comp.location,
          onIconClick: () {
            String route = _getRoute(user!, comp);
            Navigator.pushNamed(context, route, arguments: comp);
          },
        )
      );
    }

    return cards;
  }

  void searchBarFocus(){
    setState(() {
      _searchBarVisible = !_searchBarVisible;
    });

    if(_searchBarVisible){
      _focusNode.requestFocus();
    }    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar(
        "Competições", 
        actions: [
          IconButton(
            onPressed: searchBarFocus, 
            icon: const Icon(Icons.search)
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
              children: [
                Visibility(
                  visible: _searchBarVisible,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: searchBarFocus, 
                        icon: const Icon(Icons.search)
                      ),
                      Flexible(
                        child: Searchbar(
                          _focusNode, 
                          textColor: AppColors.blue, 
                        ) 
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: _displayCards(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: !_searchBarVisible,
        child: const BottomNavBar(currentIndex: 1)
      ),
    );
  }
}