import 'package:central_jogos/authentification/sign_in.dart';
import 'package:central_jogos/widgets/app_title.dart';
import 'package:central_jogos/widgets/clickable_text.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/google_button.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/password_textfield.dart';
import 'package:central_jogos/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:central_jogos/colors/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const AppTitle(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    const Padding(
                      padding: EdgeInsets.only(top: 20, right: 25, left: 25),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.black
                        ),
                      ),
                    ),
                    CustomTextfield(
                      hint: "abc@email.com", 
                      prefixIcon: Icon(Icons.email_sharp),
                      onchanged: (value) {
                        setState(() {
                          email = value;

                          if(email!.trim().isEmpty){
                            email = null;
                          }
                        });  
                      },
                      value: email,
                    ), 
                    PasswordTextfield(
                      hint: "ExemploDeSenha123#@", 
                      onchanged: (value) {
                        setState(() {
                          password = value;
                        });
                    },),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            spacing: 10,
                            children: [
                              SwitchButton(),
                              Text(
                                "Lembrar-me", 
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black
                                ),
                              ),
                            ],
                          ),
                          ClickableText(
                            content: "Esqueceu a senha?", 
                            color: AppColors.blue, 
                            activeColor: Colors.purpleAccent,
                            callbackfunc: (){
                              Navigator.pushNamed(context, "/redefine_password");
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 45, right: 45),
                  child: Column(
                    spacing: 25,
                    children: [
                      MainButton(
                        text: "entrar", 
                        backgColor: AppColors.blue,
                        callBackFunc: () async {
                          bool allFieldsAreFilled = email != null && email!.isNotEmpty 
                            && password != null && password!.isNotEmpty;

                          if(allFieldsAreFilled){
                            bool op = await signInWithEmailAndPassword(context, email!, password!);

                            if(op && context.mounted){
                              Navigator.pushReplacementNamed(context, "/explore");
                            }
                          }

                          else{
                            showSnackBar(context, 
                              "Preencha os campos de email e senha corretamente!"
                            );
                          }
                        },
                      ),
                      const Text("OU", style: TextStyle(fontSize: 16)),
                      GoogleButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Não tem uma Conta?",
                        style: TextStyle(
                          fontSize: 16,
                        )
                      ),
                      ClickableText(
                        color: AppColors.blue, 
                        activeColor: Colors.purpleAccent, 
                        content: "Cadastre-se",
                        callbackfunc: (){
                          Navigator.pushNamed(context, "/signup");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class SwitchButton extends StatefulWidget{
  const SwitchButton({super.key});

  @override
  State<StatefulWidget> createState() => SwichButtonState();
}

class SwichButtonState extends State<SwitchButton>{
  bool _on = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _on,
      onChanged: (value){
        setState(() {
          _on = ! _on;
        });
      },
      activeColor: Colors.white,
      activeTrackColor: AppColors.blue,
    );
  }
}