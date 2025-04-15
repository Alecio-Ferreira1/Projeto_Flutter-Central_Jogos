import 'package:flutter/material.dart';
import 'package:central_jogos/colors/colors.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({required this.currentIndex,super.key});

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {  
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _changePage(int value){
    late String nextRoute;
    
    switch(value){
      case 0: nextRoute = "/explore";
      case 1: nextRoute = "/competition_options";
      case 2: nextRoute = "/subscriptions";
      case 3: nextRoute = "/profile";
      case _: return;
    }

    String? currentPage = ModalRoute.of(context)?.settings.name;

    if(currentPage != nextRoute){
      if(currentPage != null && currentPage == "/explore"){
        Navigator.pushNamed(context, nextRoute);
        return;
      }

      if(nextRoute == "/explore"){
        Navigator.popUntil(context, ModalRoute.withName("/explore"));
      }

      Navigator.pushReplacementNamed(context, nextRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + 30,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
    
          _changePage(value);
        },
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 100,
        selectedItemColor: const Color(0xFF0000FF),
        selectedLabelStyle: const TextStyle(color: AppColors.black),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explorar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Competições",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Inscrições",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}