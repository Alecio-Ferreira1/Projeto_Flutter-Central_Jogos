import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/competition.dart';
import 'package:central_jogos/widgets/bottom_navigation_bar.dart';
import 'package:central_jogos/widgets/simple_card.dart';
import 'package:central_jogos/widgets/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final FocusNode _focusNode = FocusNode();
  List<Competition> competitions = [];
  List<SimpleCard> cards = [];

  @override void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCompetitions();
  }

  void getCompetitions() async {
    if(!mounted) return;

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

  List<Widget> displayCards(){
    cards.clear();

    for(Competition comp in competitions){
      if(comp.status != "Finalizado"){
        cards.add(SimpleCard(competition: comp));
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFF4A43EC),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(33),
              bottomRight: Radius.circular(33),
            ), 
          ),
          clipBehavior: Clip.none,
          leading: IconButton(
            icon: const Icon(Icons.search, color: Colors.white,),
            onPressed: (){
              _focusNode.requestFocus();
            },
          ),
          title: Searchbar(_focusNode),
          actions: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5C55EE),
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/notifications");
                }, 
                icon: const Icon(Icons.notifications, color: Colors.white,)
              ),
            ),
            const SizedBox(width: 20,)
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Competições que ocorrerão em breve:",
                      style: TextStyle(
                        fontSize: 18, 
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: displayCards(),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}