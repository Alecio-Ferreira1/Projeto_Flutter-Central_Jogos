import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> signInWithEmailAndPassword(
  BuildContext context, String email, String password) async{

  try{
    UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
        email: email.trim(), 
        password: password
    );

    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login realizado com sucesso! Seja bem vindo, "
            "${userCredential.user?.displayName}",
            style: TextStyle(fontSize: 16.5),
          ),
          duration: Duration(milliseconds: 2500),
        ),
      );
    }

    return true;
  }

  on FirebaseAuthException catch (e){
    String errorMessage = "Erro no login!";

    if(e.code == "user-not-found"){
      errorMessage = "E-mail não encontrado!";
    }

    else if(e.code == "wrong-password"){
      errorMessage = "Senha incorreta!";
    }

    else if(e.code == "invalid-email"){
      errorMessage = "E-mail inválido!";
    }

    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(milliseconds: 2500),
        ),
      );
    }

    return false;
  }
}