import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/widgets/clickable_text.dart';
import 'package:flutter/material.dart';

List<String> imgPaths = [  
  "assets/icons/pawn.png",
  "assets/icons/volleyball.png",
  "assets/icons/soccer_ball.png",
  "assets/icons/placeholder.png",
];

class CompetitionCard extends StatelessWidget {
  final int category;
  final DateTime date;
  final String title;
  final String? local;
  final bool cancelSubsOpt, editMode;
  final void Function()? onIconClick, onCancelSubs, onDelete;

  const CompetitionCard({
    required this.category, required this.title, required this.date,
    this.local, this.cancelSubsOpt = false, this.editMode = false,
    this.onIconClick, this.onCancelSubs, this.onDelete, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFE), 
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: onIconClick,
              child: Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCD6C), 
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.asset(imgPaths[category]),
              ),
            ),
          ),
          SizedBox(
            height: 92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data: ${date.day}/${date.month}/${date.year}", 
                  style: const TextStyle(color: AppColors.blue)
                ),
                Text(
                  title, 
                  style: const TextStyle(
                    color: AppColors.black, 
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Visibility(
                  visible: local != null && !editMode,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        local??'', 
                        style: const TextStyle(color: Color(0xFF747688), 
                        fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: cancelSubsOpt,
                  child: ClickableText(
                    activeColor: Colors.purpleAccent, 
                    content: "Cancelar Inscrição", 
                    color: Colors.red,
                    fontSize: 14,
                    callbackfunc: onCancelSubs,
                  ),
                ),
                Visibility(
                  visible: editMode,
                  child: Row(
                    children: [
                      ClickableText(
                        activeColor: Colors.purpleAccent, 
                        content: "Editar",
                        color: Colors.green,
                        fontSize: 15,
                        callbackfunc: () {
                          Navigator.pushNamed(context, "/competitions-edit");
                        },
                      ),
                      const SizedBox(width: 25,),
                      ClickableText(
                        activeColor: Colors.purpleAccent, 
                        content: "Excluir",
                        color: Colors.red,
                        fontSize: 15,
                        callbackfunc: onDelete,
                      ),
                      const SizedBox(width: 25,),
                      ClickableText(
                        activeColor: Colors.purpleAccent, 
                        content: "Visualizar",
                        color: Colors.blue,
                        fontSize: 15,
                        callbackfunc: (){
                          Navigator.pushNamed(context, "/competition-organizer");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
