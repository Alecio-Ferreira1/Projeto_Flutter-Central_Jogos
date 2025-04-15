import 'package:firebase_auth/firebase_auth.dart';
import 'package:central_jogos/authentification/google_auth.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget{
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await signInWithGoogle(context);

        User? user = FirebaseAuth.instance.currentUser;

        if(user != null && context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login realizado com sucesso! Seja bem vindo, "
                "${user.displayName}",
                style: TextStyle(fontSize: 16.5),
              ),
              duration: Duration(milliseconds: 2500),
            ),
          );

          Navigator.pushNamed(context, "/explore");
        }
      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 120),
        elevation: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 60,
        child: Image.asset("assets/google-logo.png"),
      )
    );
  }
}