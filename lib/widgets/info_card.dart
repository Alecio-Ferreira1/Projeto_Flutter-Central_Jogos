import 'package:central_jogos/colors/colors.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String? title, desc;
  final dynamic icon;
  final Color? color;
  
  const InfoCard({
    required this.title, this.desc, 
    required this.icon, this.color, super.key
  });
  
  dynamic getIcon(){
    if(icon.runtimeType == String){
      return Image.asset(icon, scale: 2,);
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12)
          ),
          child: getIcon(),
        ),
        const SizedBox(width: 15,),
        SizedBox(
          height: 48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title??'', 
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  decoration: TextDecoration.none
                ),
              ),
              Visibility(
                visible: desc == null ? false : true,
                child: Text(desc??'',
                  style: const TextStyle(
                    color: Color(0xFF747688),
                    fontSize: 14,
                    decoration: TextDecoration.none
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}