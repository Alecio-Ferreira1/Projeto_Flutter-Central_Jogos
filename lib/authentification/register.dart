import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> registerWithEmailAndPassword(
  BuildContext context, String email, String password, String? username) async{

  try{
    UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
        email: email.trim(), 
        password: password
    );

    userCredential.user?.updateDisplayName(username);

    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Conta criada com sucesso: ${userCredential.user?.email}",
            style: TextStyle(fontSize: 16.5),
          ),
          duration: Duration(milliseconds: 2500),
        ),
      );
    }

    return true;
  }

  on FirebaseAuthException catch (e){
    String errorMessage = "Erro no registro!";

    if(e.code == "weak-password"){
      errorMessage = "A senha é muito fraca. Inclua números," 
        " caracteres especiais letras maiúsculas e letras minúsculas.";
    }

    else if(e.code == "email-already-in-use"){
      errorMessage = "Esse e-mail já foi registrado";
    }

    else if(e.code == "invalid-email"){
      errorMessage = "E-mail inválido!";
    }

    else if(e.code == "network-request-failed"){
      errorMessage = "Falha na conexão de rede. Verifique" 
        "sua internet e tente novamente.";
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