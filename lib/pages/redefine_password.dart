import 'package:central_jogos/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class RedefinePassword  extends StatefulWidget {
  const RedefinePassword({super.key});

  @override
  State<RedefinePassword> createState() => _RedefinePasswordState();
}

class _RedefinePasswordState extends State<RedefinePassword> {
  String? email;

  Future<bool> sendResetPasswordWithEmail(BuildContext context) async{
    if(email == null) return false;
    
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);

      if(context.mounted){
        showSnackBar(
          context, 
          "Um e-mail de verificação foi enviado para $email"
        );
      }

      return true;
    }

    on FirebaseAuthException catch(e){
      String errorMessage = "Ocorreu um erro ao enviar o e-mail de recuperação.";


      if(e.code == "invalid-email"){
        errorMessage = "E-mail inválido (inexistente).";
      }

      else if(e.code == "user-not-found"){
        errorMessage = "Não há usuários com este e-mail.";
      }

      if(context.mounted){
        showSnackBar(context, errorMessage);
      }
    
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar("Redefinir Senha", callbackfunc: () {
        Navigator.pop(context);
      },),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SafeArea(
          child: Column(
            spacing: 25,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Text(
                        "Por favor, insira o seu e-mail para\nsolicitar uma redefinição de senha:", 
                        style: TextStyle(fontSize: 16),
                      ),
                    ]
                ),
              ),
              CustomTextfield(
                hint: "abc@email.com", 
                prefixIcon: Icon(Icons.email),
                onchanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: MainButton(
                  text: "Enviar", 
                  backgColor: AppColors.blue,
                  callBackFunc: () async {
                    bool? operationResult = await confirmMessageDialog(
                      context, 
                      "Solicitar nova senha com este e-mail?",
                      fontSize: 16,
                    );

                    bool? op;

                    if(context.mounted && operationResult == true){
                      op = await sendResetPasswordWithEmail(context);
                    }

                    if(op == true && context.mounted){
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}