import 'package:central_jogos/widgets/info_card.dart';
import 'package:central_jogos/widgets/team_placeholder.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class Players extends StatelessWidget {
  const Players({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppbar("Jogadores"),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              spacing: 10,
              children: [
                TeamPlaceHolder(
                  title: "Equipe: Tigres Dourados",
                  players: [
                    InfoCard(
                      title: "Carlos Silva (Atacante)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Ana Santos (Meio-campo)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "João Oliveira (Defensor)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Mariana Costa (Goleira)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Pedro Lima (Atacante)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                  ],
                ),
                TeamPlaceHolder(
                  title: "Equipe: Águias Vermelhas",
                  players: [
                    InfoCard(
                      title: "Lucas Almeida (Defensor)",
                      icon: Image.asset("assets/icons/generic_avatar.png")),
                    InfoCard(
                      title: "Beatriz Farias (Meio-campo)",
                      icon: Image.asset("assets/icons/generic_avatar.png")),
                    InfoCard(
                      title: "Isabela Nunes (Goleiro)",
                      icon: Image.asset("assets/icons/generic_avatar.png")),
                    InfoCard(
                      title: "Mariana Costa (Goleira)",
                      icon: Image.asset("assets/icons/generic_avatar.png")),
                    InfoCard(
                      title: "Mateus Fonseca (Meio-campo)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                  ],
                ),
                TeamPlaceHolder(
                  title: "Equipe: Falcões Negros",
                  players: [
                    InfoCard(
                      title: "Daniel Moraes (Atacante)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Fernanda Souza (Defensora)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Gabriel Torres (Meio-campo)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Sofia Martins (Atacante)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                    InfoCard(
                      title: "Victor Ferreira (Goleiro)",
                      icon: Image.asset("assets/icons/generic_avatar.png")
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}