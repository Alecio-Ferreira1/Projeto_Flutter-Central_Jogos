import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/entities/competition.dart';
import 'package:central_jogos/pages/my_subscriptions.dart';
import 'package:central_jogos/widgets/clickable_text.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:central_jogos/widgets/info_card.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class CompetitionDetails extends StatefulWidget{
  final int version;
  static const int subscribe = 0;
  static const int manageSubscription = 1;
  static const int finished = 2;
  static const int organizer = 3;

  const CompetitionDetails({required this.version, super.key});

  @override
  State<CompetitionDetails> createState() => _CompetitionDetailsState();
}

class _CompetitionDetailsState extends State<CompetitionDetails> {
  final List<String> _btnLabels = [
    "INSCREVA-SE", "CANCELAR INSCRIÇÃO", "FINALIZADO", "ENCERRAR COMPETIÇÃO"
  ];

  final List<Color> _btnColors = [
    AppColors.blue, Colors.red, Colors.grey, Colors.red
  ];

  Competition? competition;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args = ModalRoute.of(context)?.settings.arguments;
    competition = args as Competition;
  } 

  bool _validVersion(){
    return widget.version < _btnLabels.length  && widget.version >= 0;
  }

  void _showDialog(BuildContext context) async {
    if(widget.version == CompetitionDetails.subscribe){
      Navigator.pushNamed(
        context, "/subscribe",
        arguments: competition,
      );
      return;
    }

    if(widget.version == CompetitionDetails.finished) return;

    bool? confirm = await confirmMessageDialog(
      context, 
      widget.version == CompetitionDetails.manageSubscription ? 
        "Tem certeza que deseja cancelar a inscrição?" : 
        "Tem certeza que deseja encerrar a competição?",
      buttonFontColor: Colors.black,
      messagefontColor: Colors.red,
    );

    if(confirm != null && context.mounted){
      if(confirm == false) return;

      switch(widget.version){
        case 0:
        case 1: 
          Navigator.pushReplacementNamed(
            context, "/competition-subscribe",
            arguments: competition
          ); 
          setState(() {
            cancelSubscription(competition?.id??'');
          });
        case 2:
        case 3: 
          Navigator.pushReplacementNamed(
            context, 
            "/competition-finished",
            arguments: competition
          );  //marcar competição como finalizada
        default:
      }
    }
  }

  String chooseIconFromMode(String modality){
    switch(modality){
      case "Vôlei":  return "assets/icons/volleyball.png";
      case "Futebol": return "assets/icons/soccer_ball.png";
      case "Xadrez": return "assets/icons/pawn.png";
      default: return "assets/icons/placeholder.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar("Detalhes da Competição",),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Text(
                    competition?.name??'', 
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Inscrições: ",
                              style: TextStyle(fontSize: 16, color: AppColors.blue),
                            ),
                            Text(
                              "De (${formatDate(competition?.startSubDate??DateTime(0))}) a "
                              "(${formatDate(competition?.endSubDate??DateTime(0))}).",
                              style: TextStyle(fontSize: 16, color: AppColors.black),
                            )
                          ],
                        ),
                      ),
                      InfoCard(
                        title: "Modalidade: ${competition?.mode}",
                        icon: chooseIconFromMode(competition?.mode??''),
                        color: Color(0xFFEAEDFF),
                      ),
                      InfoCard(
                        title: "Data de início: (${formatDate(competition?.startDate??DateTime(0))})",
                        desc: "Horário: ${concatZeroIfNecessary(competition?.time.hour??0)}:"
                        "${concatZeroIfNecessary(competition?.time.minute??0)}", 
                        icon: Icon(Icons.calendar_month, color: AppColors.blue,),
                        color: Color(0xFFEAEDFF),
                      ),
                      InfoCard(
                        title: "Data de término: (${formatDate(competition?.endDate??DateTime(0))})",
                        desc: "Horário: ${concatZeroIfNecessary(competition?.time.hour??0)}:"
                        "${concatZeroIfNecessary(competition?.time.minute??0)}", 
                        icon: Icon(Icons.calendar_month, color: AppColors.blue,),
                        color: Color(0xFFEAEDFF),
                      ),
                      InfoCard(
                        title: competition?.location,
                        desc: "Local", 
                        icon: Icon(Icons.location_on_sharp, color: AppColors.blue,),
                        color: Color(0xFFEAEDFF),
                      ),
                      Visibility(
                        visible: widget.version != CompetitionDetails.organizer,
                        child: InfoCard(
                          title: competition?.organizer, 
                          icon: Icon(Icons.person),
                        ),
                      ),
                      Text(
                        "Sobre a competição:", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(competition?.desc??'', style: TextStyle(fontSize: 16),),
                    ],
                  ),
                  Visibility(
                    visible: widget.version != CompetitionDetails.subscribe,
                    child: Container(
                      padding: const EdgeInsets.all(7.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClickableText(
                            activeColor: Colors.red, 
                            content: "Ver jogadores", 
                            color: AppColors.blue,
                            callbackfunc: () {
                              Navigator.pushNamed(context, "/players");
                            },
                            fontSize: 20,
                          ),
                          ClickableText(
                            activeColor: Colors.red, 
                            content: "Ver partidas", 
                            color: AppColors.blue,
                            callbackfunc: () {
                              Navigator.pushNamed(context, "/view_matches");
                            },
                            fontSize: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _validVersion(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        text: _validVersion() ? _btnLabels[widget.version] : '', 
                        backgColor: _validVersion() ? _btnColors[widget.version] : Colors.white,
                        rightArrow: widget.version == CompetitionDetails.subscribe,
                        callBackFunc: () => _showDialog(context),
                        fontSize: 15.5,
                      ),
                    ),
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

String formatDate(DateTime date){
  return "${date.day}/${date.month}/${date.year}";
}

String concatZeroIfNecessary(int parameter){
  if(parameter < 10) return "0$parameter";
  return "$parameter";
}