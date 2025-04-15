import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signInWithGoogle(BuildContext context) async {
  try{
    GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if(googleUser == null){
      return null;
    }

    GoogleSignInAuthentication googleAuth =  await googleUser.authentication;
    OAuthCredential credentialFromGoogle = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
      .signInWithCredential(credentialFromGoogle); 
    
    return userCredential.user;
  }

  catch (e){
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erro ao entrar com o gogle: $e",
            style: TextStyle(fontSize: 16),
          ),
        )
      );
    }

    return null;
  }
}