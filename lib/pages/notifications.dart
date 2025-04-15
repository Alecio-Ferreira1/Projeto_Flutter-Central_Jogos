import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/widgets/notification_card.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget{
  final bool _emptyNotifications = true;

  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar(
        "Notificações", 
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
          const SizedBox(width: 20,),
        ],
      ),
      body: !_emptyNotifications ? const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: NotificationCard(
              icon: Icon(Icons.messenger_sharp), 
              desc: "Bem vindo ao Central Jogos IFMA, usuário.", 
              timeDesc: "Agora mesmo"
            ),
          ),
          Padding(
           padding: EdgeInsets.all(15.0),
            child: NotificationCard(
              icon: Icon(Icons.error_outline, color: Colors.red,), 
              desc: "Lembrete: O Campeonato de Xadrez do IFMA\n" 
              "Campus Caxias começa no dia 06/05.\n Horário: 13h00 às 18h00", 
              timeDesc: "Agora mesmo",
            ),
          ),
        ],
      ) : Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/img/bell.png"),
            const Text(
              "Sem Notificações", 
              style: TextStyle(
                fontSize: 18, color: AppColors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const Text(
              "Todas as notificações foram lidas!",
              style: TextStyle(fontSize: 18, color: Color(0xFF3C3E56)),
            ),
          ],
        ),
      ),
    );
  }
}