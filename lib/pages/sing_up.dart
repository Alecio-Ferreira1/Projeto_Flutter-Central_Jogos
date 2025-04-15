import 'package:central_jogos/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:central_jogos/authentification/register.dart';
import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/database/db_crud.dart';
import 'package:central_jogos/entities/user.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/drop_down_list.dart';
import 'package:central_jogos/widgets/google_button.dart';
import 'package:central_jogos/widgets/password_textfield.dart';
import 'package:central_jogos/widgets/title_appBar.dart';
import 'package:flutter/material.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/clickable_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, email, recoveryEmail, gender;
  String? password, confirmPassword, phoneNumber;

  bool _verifyFields(){
    if(name != null && name!.trim().isNotEmpty && email != null && 
      email!.trim().isNotEmpty && recoveryEmail != null && 
      recoveryEmail!.trim().isNotEmpty && gender != null &&
      gender!.trim().isNotEmpty && password != null && 
      confirmPassword != null && phoneNumber != null && 
      phoneNumber!.trim().isNotEmpty
    ){
      if(password != confirmPassword){
        showSnackBar(context, "As senhas não correspondem!");
        return false;
      }

      else if(phoneNumber!.length < 11){
        showSnackBar(context, "Preencha o número de telefone corretamente!");
        return false;
      }

      else{
        return true;
      }
    }

    else{
      showSnackBar(context, "Preencha todos os campos!");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppbar("Cadastrar"),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfield(
                        hint: "Nome Completo", 
                        prefixIcon: Icon(Icons.person),
                        onchanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
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
                      PasswordTextfield(
                        hint: "Senha",
                        onchanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      PasswordTextfield(
                        hint: "Confirmar Senha",
                        onchanged: (value) {
                          setState(() {
                            confirmPassword = value;
                          });
                        },
                      ),
                      CustomTextfield(
                        hint: "Número de Celular", 
                        prefixIcon: Icon(Icons.phone_rounded),
                        numericKeyBoard: true,
                        onchanged: (value){
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        maxLenght: 11,
                      ),
                      CustomTextfield(
                        hint: "Email de Recuperação", 
                        prefixIcon: Icon(Icons.email),
                        onchanged: (value) {
                          setState(() {
                            recoveryEmail = value;
                          });
                        },
                      ),
                      DropDownList(
                        items: ["Masculino", "Feminino"], 
                        hint: "Escolha seu sexo: ",
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 15,
                      children: [
                        MainButton(
                          text: "Continuar", 
                          backgColor: AppColors.blue,
                          callBackFunc: () async{
                            if(_verifyFields()){
                              bool op = await registerWithEmailAndPassword(
                                context, email!, password!, name
                              );

                              if(op && context.mounted){
                                AppUser user = AppUser(
                                  name: name!, 
                                  email: email!, 
                                  gender: gender!, 
                                  recoveryEmail: recoveryEmail!, 
                                  phoneNumber: phoneNumber!
                                );

                                bool userAdded = await DBCrud(
                                  collectionPath: 'users', 
                                  context: context
                                ).create(
                                  email!.replaceAll('.', '_'), 
                                  user.toMap()
                                ); 

                                if(userAdded && context.mounted){
                                  Navigator.pushNamed(context, "/explore",);
                                }

                                else{
                                  await FirebaseAuth.instance.currentUser?.delete();
                                }
                              }
                            }
                          },
                        ),
                        const Text("OU", style: TextStyle(fontSize: 16)),
                        GoogleButton(),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já possui uma Conta?",
                          style: TextStyle(
                            fontSize: 16,
                          )
                        ),
                        const SizedBox(width: 10),
                        ClickableText(
                          color: AppColors.blue, 
                          activeColor: Colors.purpleAccent, 
                          content: "Entre",
                          callbackfunc: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}