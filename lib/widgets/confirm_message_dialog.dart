import 'package:flutter/material.dart';

Future<bool?> confirmMessageDialog(
  BuildContext context, String? message, 
  {double fontSize = 16, Color? messagefontColor, 
  Color? buttonFontColor, bool okClose = false}
) async {
  if(!context.mounted) return null;
  
    return await showDialog<bool>(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          content: Text(
            message??'',
            style: TextStyle(fontSize: fontSize, color: messagefontColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), 
              child: Text(
               okClose ? "Ok" : "Sim",
                style: TextStyle(fontSize: fontSize, color: buttonFontColor),
              )
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), 
              child: Text(
                okClose ? "Fechar" : "Não",
                style: TextStyle(fontSize: fontSize, color: buttonFontColor),
              ),
            ),
          ]
        );
      }
    );
  }