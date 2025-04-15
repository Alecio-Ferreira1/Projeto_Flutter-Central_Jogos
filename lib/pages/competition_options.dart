import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/widgets/bottom_navigation_bar.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class CompetitionsOptions extends StatelessWidget{
  const CompetitionsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppbar("Competições"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 55,
            children: [
              SizedBox(
                height: 58,
                child: MainButton(
                  text: "Buscar competições", 
                  backgColor: AppColors.blue,
                  rightArrow: false,
                  fontSize: 15,
                  callBackFunc: (){
                    Navigator.pushNamed(context, "/view_competitions");
                  },
                ),
              ),
              SizedBox(
                height: 58,
                child: MainButton(
                  text: "Ver suas competições", 
                  backgColor: AppColors.blue,
                  rightArrow: false,
                  fontSize: 15,
                  callBackFunc: () {
                    Navigator.pushNamed(context, "/edit_competitions");
                  },
                ),
              ),
              SizedBox(
                height: 58,
                child: MainButton(
                  text: "Criar competição", 
                  backgColor: AppColors.blue,
                  rightArrow: false,
                  callBackFunc: () {
                    Navigator.pushNamed(context, "/competitions");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}